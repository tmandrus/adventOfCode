#!/usr/bin/env bash

file=day6.dat
part=1

if [[ ${part} -eq 1 ]]; then
# /////////////////////////////////////////////////////////////////////////////
    #part 1 // 0.08s // 1300 dbpw
    searchWidth=4 #width of character subset to check
else
    #part 2 // 0.26s // 3986 lcfjqpdwznsbrh
    searchWidth=14 #width of character subset to check
fi

mapfile -t stream < $file
charLength=${#stream}
i=0 #counter for outer loop
while [[ $i -lt $charLength ]]; do

#   -- extract subset of letters from bit stream
    currentFour=${stream:i:searchWidth} 

    j=0 #counter for inner loop
    count=0 #number of unique letters in subset

#   -- extract one letter from our subset
#   -- delete matches of extracted letter
#   -- if only 1 letter is matched, look at the next letter, otherwise just start again
#   -- if we have four unique letters, print the spot and quit
    while [[ $j -lt $searchWidth ]]; do
        check=${currentFour:$j:1}
        removed=${currentFour//[$check]/}
        length=${#removed}
        if [[ length -eq $(($searchWidth - 1)) ]]; then
            ((count = count + 1))
            (( j = j + 1))
        else
            break
        fi
    done

#   -- quit searching after the first set of unique letters
    if [[ $count -eq $searchWidth ]]; then
        break 1
    fi
    (( i = i + 1))
done

echo Position of stream for part ${part}: $(($i + $searchWidth))
echo Unique letters: $currentFour
 