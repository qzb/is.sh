#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )

. $DIR/tests/assert.sh
. $DIR/is.sh

# prepare dirs and files for tests
cd `mktemp -d`
touch file
mkdir dir
ln -s file symlink_file
ln -s dir symlink_dir


#
# Helpers
#

assert_true() {
    assert_raises "$1" 0
}

assert_false() {
    assert_raises "$1" 1
}


#
# Tests
#

# is file
assert_true  "is file ./file"
assert_true  "is file ./symlink_file"
assert_false "is file ./dir"
assert_false "is file ./symlink_dir"
assert_false "is file ./nothing"

# is directory
assert_false "is directory ./file"
assert_false "is directory ./symlink_file"
assert_true  "is directory ./dir"
assert_true  "is directory ./symlink_dir"
assert_false "is directory ./nothing"

# is link
assert_false "is link ./file"
assert_true  "is link ./symlink_file"
assert_false "is link ./dir"
assert_true  "is link ./symlink_dir"
assert_false "is link ./nothing"

# is existent
assert_true  "is existent ./file"
assert_true  "is existent ./symlink_file"
assert_true  "is existent ./dir"
assert_true  "is existent ./symlink_dir"
assert_false "is existent ./nothing"

# is number
assert_true  "is number 123"
assert_true  "is number 123.456"
assert_false "is number abc"
assert_false "is number 123ff"
assert_false "is number 123,456"
assert_false "is number 12e3"

# is empty
assert_true  "is empty"
assert_true  "is empty ''"
assert_false "is empty abc"

# is gt
assert_false "is gt 111 222"
assert_false "is gt 222 222"
assert_true  "is gt 333 222"
assert_false "is gt abc 222"
assert_false "is gt 222 abc"
assert_false "is gt abc abc"

# is lt
assert_true  "is lt 111 222"
assert_false "is lt 222 222"
assert_false "is lt 333 222"
assert_false "is lt abc 222"
assert_false "is lt 222 abc"
assert_false "is lt abc abc"

# is ge
assert_false "is ge 111 222"
assert_true  "is ge 222 222"
assert_true  "is ge 333 222"
assert_false "is ge abc 222"
assert_false "is ge 222 abc"
assert_false "is ge abc abc"

# is le
assert_true  "is le 111 222"
assert_true  "is le 222 222"
assert_false "is le 333 222"
assert_false "is le abc 222"
assert_false "is le 222 abc"
assert_false "is le abc abc"

# is equal
assert_false "is equal 111 222"
assert_true  "is equal 222 222.0"
assert_false "is equal 333 222"
assert_false "is equal abc 222"
assert_false "is equal 222 abc"
assert_true  "is equal abc abc"

# is matching
assert_true  "is matching 'abc' '^[a-c]+$'"
assert_false "is matching 'Abc' '^[a-c]+$'"
assert_false "is matching 'abd' '^[a-c]+$'"

# is substring
assert_true  "is substring cde abcdef"
assert_false "is substring cdf abcdef"

# negation
assert_true  "is not number abc"
assert_false "is not number 123"
assert_true  "is not equal abc def"
assert_false "is not equal abc abc"

# test aliases
assert_true  "is dir ./dir"
assert_true  "is symlink ./symlink_file"
assert_true  "is existing ./file"
assert_true  "is exist ./file"
assert_true  "is exists ./file"
assert_true  "is match 'abc' '^[a-c]+$'"

# unknown condition
assert_false "is spam foo bar"

# end of tests
assert_end
