#!/usr/bin/env bash

file=day1.dat
part=2

#   -- for part 1, we need there to be a blank line at the end of the file
lastline=$(tail -n 1 $file)
if [[ ! -z ${lastline} ]]; then
    echo >> $file
fi

if [[ ${part} -eq 1 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 1 0m0.557s

#   -- define variable to hold number of elves, number of snacks, intermittent caloric sum, 

elfCount=0
intCals=()
snacks=0
backpack=() #elf, # snacks, calories
while read -r line || [[ -n "${line}" ]]; do

#   -- check whether we hit a blank line. If so, store elf, food item count, and calorie count  

    if [[ -z ${line} ]]; then
        (( elfCount = elfCount + 1))
        calorieCount=$(echo "${intCals[@]/%/+}0" | bc)
        backpack+=("${elfCount}" "${snacks}" "${calorieCount}")
        # backpack+="${snacks} "
        # backpack+=" ${calorieCount} "
        intCals=()
        snacks=0
    else
        intCals[${#intCals[@]}]=${line}
        (( snacks = snacks + 1))
    fi
   
done < ${file}

# echo ${backpack[2]}
# for (( c=2; c<=${#backpack[@]}; c=c+1 )); do
bigCal=0
i=2
while (( i < ${#backpack[@]} )); do
    if [[ ${backpack[$i]} -gt bigCal ]]; then
        bigCal=${backpack[$i]}
    fi
    (( i = i + 3))
done

echo Answer to part 1: $bigCal
# /////////////////////////////////////////////////////////////////////////////
fi

if [[ ${part} -eq 2 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 2 0m0.505s
#this solves both parts since we didn't need to store number of elves or number of food items for pt2...
intCals=()
backpack=() #just calorie counts
while read -r line || [[ -n "${line}" ]]; do

#   -- check whether we hit a blank line. If so, sum calories

    if [[ -z ${line} ]]; then
        backpack+=("$(echo "${intCals[@]/%/+}0" | bc)")
        intCals=()
    else
        intCals[${#intCals[@]}]=${line}
    fi
   
done < ${file}

IFS=$'\n' 
sortedBackpack=($(sort --numeric-sort -r <<< "${backpack[*]}"))
unset IFS
echo Anwer to part 1: ${sortedBackpack[0]}
echo Answer to part 2: $(echo "${sortedBackpack[0]/%/+}" "${sortedBackpack[1]/%/+}" "${sortedBackpack[2]/%/+}0" | bc)

# /////////////////////////////////////////////////////////////////////////////
fi
