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

for (( i=1; i<=$PARITY; i++ )); do
    next_pol=($i 1 $(for ((g=2; g<$PARITY; g++)); do echo "0 "; done))

    for (( j=0; j<$PARITY; j++ )); do
        for (( k=0; k<2; k++)); do
            prod=0
            if (( ${coefficients[$j]}!=0 && ${next_pol[$k]}!=0 )); then
                (( prod=(${log[${coefficients[$j]}]}+${log[${next_pol[$k]}]})%($field_size) ))
            fi
            ((sum=$k+$j))
            ((coefficients[$sum]^=exp[$prod]))
        done
    done
done

echo -e "${coefficients[*]}" > "$OUT_FILE"