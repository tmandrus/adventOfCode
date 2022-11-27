#!/usr/bin/env bash

file=day1Test.dat
readings=($(cat ${file}))
length=${#readings[@]}

# /////////////////////////////////////////////////////////////////////////////
#part 1
i=1
mInc=0
while [[ $i -le $length ]]
do
    if [[ ${readings[$i]} -gt ${readings[$i-1]} ]];
    then
        ((mInc = mInc +1))
    fi
    ((i = i + 1))
done
echo $mInc
# /////////////////////////////////////////////////////////////////////////////

# /////////////////////////////////////////////////////////////////////////////
#part 2
i=3
mInc=0
while [[ $i -le $length ]]
do
#   -- explanation: we are considering four values, but the overlap of values 
#      two and three means we can discard them to only consider the first and 
#      fourth values. 
    if [[ ((${readings[$i]} -gt ${readings[$i-3]})) ]];
    then
        ((mInc = mInc +1 ))
    fi
    ((i = i + 1))
done
echo $mInc