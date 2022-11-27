#!/usr/bin/env bash

file=day2.dat
part=2

if [[ $part -eq 1 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 1 - path independent
down=($(grep down $file | cut -d ' ' -f 2))
up=($(grep up $file | cut -d ' ' -f 2))
forward=($(grep forward $file | cut -d ' ' -f 2))
#   -- syntax for the echo command: echo the array and replace whitespace with 
#      plus signs, then pass bc command. We have the extra zero to prevent
#      something like a+ b+ c+ | bc which will throw an error
downSum=$(echo "${down[@]/%/+}0" | bc)
upSum=$(echo "${up[@]/%/+}0" | bc)
forwardSum=$(echo "${forward[@]/%/+}0" | bc)
upDownSum=$(($downSum-$upSum))
answer=$(($upDownSum * $forwardSum))
echo $answer
# /////////////////////////////////////////////////////////////////////////////
fi

if [[ $part -eq 2 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 2 (redux) - this is now path dependent
# currently running 0.062 seconds. Sped up 100x by not opening pipes.
aim=0
forwardSum=0
depth=0
while read -r line || [ -n "$line" ]
do
    amount=${line//[!0-9]/}
    if [[ $line =~ forward ]]; then
        ((forwardSum = forwardSum + amount))
        ((depth = depth + (aim * amount)))
    # elif [[ $(echo $line | grep up -c) -eq 1 ]]; then
    elif [[ $line =~ up ]]; then
        ((aim = aim - amount))
    else
        ((aim = aim + amount))
    fi
done < "$file"
answer=$((forwardSum*depth))
echo $answer
# /////////////////////////////////////////////////////////////////////////////
fi


#worse original version of part 2... was way too slow
if [[ $part -eq 3 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 2 - this is now path dependent
# currently running 6.253s
aim=0
forwardSum=0
depth=0
while read -r line || [ -n "$line" ]
do
    move=$(echo $line | cut -d ' ' -f 1)
    amount=$(echo $line | cut -d ' ' -f 2)
    if [[ $(echo $line | grep forward -c) -eq 1 ]]; then
        ((forwardSum = forwardSum + amount))
        ((depth = depth + (aim * amount)))
    elif [[ $(echo $line | grep up -c) -eq 1 ]]; then
        ((aim = aim - amount))
    else
        ((aim = aim + amount))
    fi
done < "$file"
answer=$((forwardSum*depth))
echo $answer
# /////////////////////////////////////////////////////////////////////////////
fi