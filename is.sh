is() {
    # helper functions
    _is_number() {
        echo "$1" | grep -E '^[0-9]+(\.[0-9]+)?$' > /dev/null
        return $?
    }

    local condition="$1"
    local value_a="$2"
    local value_b="$3"

    case "$condition" in
        file)
            [ -f "$value_a" ]; return $?;;
        dir|directory)
            [ -d "$value_a" ]; return $?;;
        number)
            _is_number "$value_a"; return $?;;
        empty)
            [ -z "$value_a" ]; return $?;;
        gt)
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            echo "$value_a > $value_b" | bc | grep 1; return $?;;
        lt)
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            echo "$value_a < $value_b" | bc | grep 1; return $?;;
        ge)
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            echo "$value_a >= $value_b" | bc | grep 1; return $?;;
        le)
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            echo "$value_a <= $value_b" | bc | grep 1; return $?;;
        equal)
            [ "$value_a" = "$value_b" ]     && return 0;
            ! _is_number "$value_a"         && return 1;
            ! _is_number "$value_b"         && return 1;
            echo "$value_a == $value_b" | bc | grep 1; return $?;;
        match|matching)
            echo "$value_a" | grep -E "$value_b"; return $?;;
        substring)
            echo "$value_b" | grep -F "$value_a"; return $?;;
    esac > /dev/null

    echo "is: Cannot recognize condition \"$condition\""
    return 1
}
