#!/bin/bash

is() {
    _is_number() {
        echo "$1" | grep -E '^[0-9]+(\.[0-9]+)?$' > /dev/null
        return $?
    }

    local condition="$1"
    local value_a="$2"
    local value_b="$3"

    if [ "$condition" == "not" ]; then
        shift 1
        ! is "${@}"
        return $?
    fi

    if [ "$condition" == "a" -o "$condition" == "the" ]; then
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
        equal)
            [ "$value_a" = "$value_b" ]     && return 0;
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            awk "BEGIN {exit $value_a == $value_b ? 0 : 1}"; return $?;;
        match|matching)
            echo "$value_a" | grep -xE "$value_b"; return $?;;
        substring)
            echo "$value_b" | grep -F "$value_a"; return $?;;
    esac > /dev/null

    return 1
}

if is not equal ${BASH_SOURCE[0]} $0; then
    export -f is
else
    is "${@}"
    exit $?
fi
