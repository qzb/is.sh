# is.sh
[![Build Status](https://travis-ci.org/qzb/is.sh.svg)](https://travis-ci.org/qzb/is.sh)

Fancy alternative for old good test command.

```sh
var=123

if is equal $var 123.0; then
    echo "it just works"
fi

if is not a substring $var "foobar"; then
    echo "and it's easy to read"
fi
```

## Conditions

* ``is equal $valueA $valueB`` - checks if values are the same or if they are equal numbers
* ``is matching $regexp $value`` - checks if whole value matches to regular expression
* ``is substring $valueA $valueB`` - checks if first value is a part of second one
* ``is empty $value`` - checks if value is empty
* ``is number $value`` - checks if value is a number
* ``is gt $numberA $numberB`` - true if first number is greater than second one
* ``is lt $numberA $numberB`` - true if first number is less than second one
* ``is ge $numberA $numberB`` - true if first number is greater than or equal to second one
* ``is le $numberA $numberB`` - true if first number is less than or equal to second one
* ``is file $path`` - checks if it is a file
* ``is dir $path`` - checks if it is a directory
* ``is link $path`` - checks if it is a symbolic link
* ``is existent $path`` - checks if there is a file or directory or anything else with this path
* ``is readable $path`` - checks if file is readable
* ``is writeable $path`` - checks if file is writeable
* ``is executable $path`` - checks if file is executable
* ``is older $pathA $pathB`` - checks if first file is older than second one
* ``is newer $pathA $pathB`` - checks if first file is newer than second one
* ``is true $value`` - true if value is equal "true" or "0"
* ``is false $value`` - oposite of ``is true $value``

## Negations

You can negate any condition by putting not in front of it.

```sh
$ is a number "abc" && echo "number"
$ is not a number "abc" && echo "not a number"
not a number
```
