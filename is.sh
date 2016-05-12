#!/bin/bash
#
# Copyright (c) 2016 Józef Sokołowski
# Distributed under the MIT License
#
# For most current version checkout repository:
# https://github.com/qzb/is.sh
#

VERSION='1.0.0'

print_help() {
cat << EOF
Conditions:
  is equal VALUE_A VALUE_B
  is matching REGEXP VALUE
  is substring VALUE_A VALUE_B
  is empty VALUE
  is number VALUE
  is gt NUMBER_A NUMBER_B
  is lt NUMBER_A NUMBER_B
  is ge NUMBER_A NUMBER_B
  is le NUMBER_A NUMBER_B
  is file PATH
  is dir PATH
  is link PATH
  is existing PATH
  is readable PATH
  is writeable PATH
  is executable PATH
  is older PATH_A PATH_B
  is newer PATH_A PATH_B
  is true VALUE
  is false VALUE

Negation:
  is not equal VALUE_A VALUE_B
EOF
}

is() {
    _is_number() {
        echo "$1" | grep -E '^[0-9]+(\.[0-9]+)?$' > /dev/null
        return $?
    }

    local condition="$1"
    local value_a="$2"
    local value_b="$3"

    if [ "$condition" == "--version" ]; then
        echo "is.sh $VERSION"
        exit
    fi

    if [ "$condition" == "--help" ]; then
        print_help
        exit
    fi

    if [ "$condition" == "not" ]; then
        shift 1
        ! is "${@}"
        return $?
    fi

    if [ "$condition" == "a" ] || [ "$condition" == "the" ]; then
        shift 1
        is "${@}"
        return $?
    fi

    case "$condition" in
        file)
            [ -f "$value_a" ]; return $?;;
        dir|directory)
            [ -d "$value_a" ]; return $?;;
        link|symlink)
            [ -L "$value_a" ]; return $?;;
        existent|existing|exist|exists)
            [ -e "$value_a" ]; return $?;;
        readable)
            [ -r "$value_a" ]; return $?;;
        writeable)
            [ -w "$value_a" ]; return $?;;
        executable)
            [ -x "$value_a" ]; return $?;;
        empty)
            [ -z "$value_a" ]; return $?;;
        number)
            _is_number "$value_a"; return $?;;
        older)
            [ "$value_a" -ot "$value_b" ]; return $?;;
        newer)
            [ "$value_a" -nt "$value_b" ]; return $?;;
        gt)
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            awk "BEGIN {exit $value_a > $value_b ? 0 : 1}"; return $?;;
        lt)
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            awk "BEGIN {exit $value_a < $value_b ? 0 : 1}"; return $?;;
        ge)
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            awk "BEGIN {exit $value_a >= $value_b ? 0 : 1}"; return $?;;
        le)
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            awk "BEGIN {exit $value_a <= $value_b ? 0 : 1}"; return $?;;
        eq|equal)
            [ "$value_a" = "$value_b" ]     && return 0;
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            awk "BEGIN {exit $value_a == $value_b ? 0 : 1}"; return $?;;
        match|matching)
            echo "$value_b" | grep -xE "$value_a"; return $?;;
        substr|substring)
            echo "$value_b" | grep -F "$value_a"; return $?;;
        true)
            [ "$value_a" == true ] || [ "$value_a" == 0 ]; return $?;;
        false)
            [ "$value_a" != true ] && [ "$value_a" != 0 ]; return $?;;
    esac > /dev/null

    return 1
}

if is not equal "${BASH_SOURCE[0]}" "$0"; then
    export -f is
else
    is "${@}"
    exit $?
fi
