#!/usr/bin/env bash

file=day3Test.dat
part=2

if [[ $part -eq 1 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 1 - runs in 0.17 seconds
#-- get the width of the line
width=($(wc -L $file))

#-- get the number of lines
wcReturn=($(wc $file))

#-- get the number of lines halved, since most significant bit is 1 if number of 0s in column is < lines/2
length=$((${wcReturn[1]}/2))
sigBits=()
i=1
#-- 
while [[ "$i" -le "${width[0]}" ]]; do

#   -- sort based on bit position
    sort -k 1.${i} $file > day3.temp
    
    j=0
#   -- read sorted file 
    while read -r line || [ -n "$line" ]; do

#       -- need to offset the bash regex by one character
        position=$((i - 1))

#       -- check whether bit value is equal to 1. Use counter j to determine how many zeroes we have
        if [[ ${line:$position:1} -eq 1 ]]; then
            # echo $j 
            sigBits[${#sigBits[@]}]=$j
            break 1
        fi
        ((j = j + 1))
    done < day3.temp

    ((i = i + 1))
done
rm day3.temp
#--get gamma function, most common bit
gamma=()
epsilon=()
for k in ${sigBits[@]}; do
    if [[ $k -gt $length ]]; then
#       -- inside this loop means greatest common bit is 0
        gamma[${#gamma[@]}]=0
        epsilon[${#epsilon[@]}]=1
    else
#       -- inside this loop means greatest common bit is 1
        gamma[${#gamma[@]}]=1
        epsilon[${#epsilon[@]}]=0
    fi
done

#-- convert binary to decimal
gammaDecimal=$(echo "$((2#$(echo ${gamma[@]} | tr -d ' ' )))")
epsilonDecimal=$(echo "$((2#$(echo ${epsilon[@]} | tr -d ' ' )))")

#-- print answer
echo Answer for part A: $((gammaDecimal*epsilonDecimal))
# /////////////////////////////////////////////////////////////////////////////
fi

if [[ $part -eq 2 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 2
echo
# /////////////////////////////////////////////////////////////////////////////
fi