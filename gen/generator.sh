#!/bin/bash

BITS=8
PRIME=369

field_size=$((2**$BITS))
element=1
i=0
exp=()
log=()

while (( $i <= $field_size-1 )); do
   exp[$i]=$element
   log[$element]=$i
    element=$(($element*2))
    if (( $element >= $field_size)); then
        element=$(($element^$PRIME))
    fi
    ((i++))
done
################################

PARITY=32

OUT_FILE="$(dirname "$(realpath -s $0)")/generator.out"

################################
echo "==>  Generator polynomial for [$PARITY parity bits]"

coefficients=(1 $(for ((i=1; i<$PARITY; i++)); do echo "0 "; done))

for (( i=0; i<$PARITY; i++ )); do
    next_pol=($((2**i)) 1)

    #function multiply
done

echo -e "${coefficients[*]}" > "$OUT_FILE"