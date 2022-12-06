#!/usr/bin/env bash

file1=day5_1.dat
file2=day5_2.dat
part=1

# if [[ ${part} -eq 1 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 1 0.114 VCTFTJQCG
#part 2 
mapfile -t stackedRows < $file1

# # shopt -s extglob #necessary for match below
# # stackedRows=("${stackedRows[@]//[[:blank:]]}")

#   -- reorder rows into columns
length=${#stackedRows[@]}
i=0
j=1
n=0
cols=()
declare -A "stacks" #make assosciative array
#   -- outer loop gets width of line
while [[ $i -le $length ]]; do 
    width=${#stackedRows[$i]}
#   -- next loop (j) holds our horiztonal position
    while [[ $j -lt $width ]]; do
        k=0
#       -- now, for this horizontal position, loop through vertically
        while [[ $k -lt $length ]]; do
            # echo line $(($k+1)) col $(($j+1)) #debug print
            # echo ${stackedRows[k]:j:1}
            cols+=("${stackedRows[k]:j:1}")
            (( k = k + 1))
        done
    ((j = j + 4))
    done
    noSpace="${cols[@]:n:$length}"
    stacks["stack${i}"]=${noSpace// /}
    # echo "${stacks["stack${i}"]}"
    ((n = n + $length))
    ((i = i + 1))
done

#   --access to stacks 
# col=stack1
# echo "${stacks[$col]}"
# echo "${stacks[stack1]}"
# or
# echo "${stacks["stack1"]}"


while read -ra line || [ -n "$line" ]; do
    m=0
    move=${line[1]}
    from=${line[3]}
    to=${line[5]}

#   -- zero offset
    ((move = move -1 ))
    ((from = from -1 ))
    ((to = to -1))

    # echo move $move from $from to $to
    while [[ m -le $move ]]; do
#       -- get column we're taking from
        colA="stack${from}"
        fromCol=("${stacks[$colA]}")
#       -- get column we're adding to
        colB="stack${to}"
        toCol=("${stacks[$colB]}")
#       -- get the single container we're moving, unless it's 3 at a time...
        if [[ $move -gt 0 && ${part} -eq 2 ]]; then
            ((numCrates=move + 1))
        else
            numCrates=1
        fi
        movingContainer=${fromCol:0:$numCrates}

# # #       -- debug print
        #   echo moving $movingContainer to $toCol

#       -- move to the new column
        toCol="${movingContainer}${toCol}"
#       -- removing from old one
        z=${#fromCol}
        fromCol=${fromCol:$numCrates:z}

# # #       -- debug print
        # echo after moving we have: $fromCol and $toCol

#       -- update assosciate array 'stacks'
        stacks["$colA"]=${fromCol}
        stacks["$colB"]=${toCol}
# #       -- debug print
        # echo just checking, we have: ${stacks[$colA]} and ${stacks[$colB]}

        ((m = m + 1 ))

        if [[ $numCrates -gt 1 ]]; then
            m=$(($move+1))
        fi

    done
        # echo next move

done < $file2
echo Final crates: ${stacks[stack0]:0:1}${stacks[stack1]:0:1}${stacks[stack2]:0:1}${stacks[stack3]:0:1}${stacks[stack4]:0:1}${stacks[stack5]:0:1}${stacks[stack6]:0:1}${stacks[stack7]:0:1}${stacks[stack8]:0:1}
# /////////////////////////////////////////////////////////////////////////////

if [[ ${part} -eq 2 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 2
echo
# 
# /////////////////////////////////////////////////////////////////////////////
fi

