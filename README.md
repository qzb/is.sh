# is.sh

Fancy alternative for old good test command.

[![NPM Version][npm-image]][npm-url]
[![Build][travis-image]][travis-url]

## Example

```sh
var=123

if is equal $var 123.0; then
    echo "it just works"
fi

if is not a substring $var "foobar"; then
    echo "and it's easy to read"
fi
```

## Installation

In order to use is.sh you can install it with one of following 1-liners:

```sh
# Unix-like
$ sudo sh -c 'cd /usr/local/bin && wget raw.githubusercontent.com/qzb/is.sh/latest/is.sh -O is && chmod +x is'

# NPM
$ npm install -g is.sh
```

If you don't want to install is.sh system-wide you can just download it and source it from your script:

```sh
$ wget raw.githubusercontent.com/qzb/is.sh/latest/is.sh
$ source ./is.sh
```

## Usage

### Conditions

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
* ``is available $command`` - checks if given command is available
* ``is older $pathA $pathB`` - checks if first file is older than second one
* ``is newer $pathA $pathB`` - checks if first file is newer than second one
* ``is true $value`` - true if value is equal "true" or "0"
* ``is false $value`` - opposite of ``is true $value``

### Negations

You can negate any condition by putting *not* in front of it.

```sh
$ is number "abc" && echo "number"
$ is not number "abc" && echo "not a number"
not a number
```

### Articles

You can add *a*, *an*, and *the* articles before condition name.

```sh
$ is a number 5
$ is not a substring abc defghi
```

## License

MIT


[npm-image]: https://img.shields.io/npm/v/is.sh.svg
[npm-url]: https://npmjs.org/package/is.sh
[travis-image]: https://img.shields.io/travis/qzb/is.sh/master.svg
[travis-url]: https://travis-ci.org/qzb/is.sh
