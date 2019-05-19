#!/bin/bash

BITS=8
# Primitive polynomial: 
# 1 + x**2 + x**3 + x**4 + x**8
# 101110001 = 369
PRIME=369

OUT_FILE="$(dirname "$(realpath -s $0)")/pow_enc.out"

################################
echo "==>  Power encoder table generation for [$BITS bits $PRIME prime]"
echo "" > "$OUT_FILE"

field_size=$((2**$BITS))
element=1
i=0

while (( $i <= $field_size-1 )); do
    echo -e "$i => $element\n" >> "$OUT_FILE"
    element=$(($element*2))
    if (( $element >= $field_size)); then
        element=$(($element^$PRIME))
    fi
    ((i++))
done