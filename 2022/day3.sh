#!/usr/bin/env bash

file=day3.dat
part=2
str=$(echo {a..z} | tr -d ' ')
sum=0

if [[ ${part} -eq 1 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 1 ~3.5s // 8252

while read -r line || [[ -n ${line} ]]; do
# /////////////////////////////////////////////////////////////////////////////
# echo ${line:0:${#line}/2} === ${line:${#line}/2}
#   -- get the string into an array
firstArr=$(fold -w1<<<${line:0:${#line}/2}) #fold works here bc sort needs newlines
secondArr=$(fold -w1<<<${line:${#line}/2}) #could use sed 's/./&\n/g'<<<$sring

firstArrSortUniq=$(sort -u <<<$firstArr)
secondArrSortUniq=$(sort -u <<<$secondArr)

# commonLetter=$(comm -1 -2 <(echo "$firstArrSortUniq") <(echo "$secondArrSortUniq"))
commonLetter=$(grep -o "$firstArrSortUniq" <<< "$secondArrSortUniq")

if [[  $str =~ "$commonLetter" ]]; then
    upCase=$(tr [:lower:] [:upper:]<<<$commonLetter)
    val=$(printf "%d" "'$upCase")
    ((val = val - 64))
    (( sum = val + sum))
else
    val=$(printf "%d" "'$commonLetter")
    ((val = val - 38))
    (( sum = val + sum))
fi

done < $file
echo Part A: $sum
# /////////////////////////////////////////////////////////////////////////////
fi

if [[ ${part} -eq 2 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 2 2.26s // 2828
wholeFile=($(cat $file))
i=0
while [[ $i -lt ${#wholeFile[@]} ]]; do

    firstArr=$(fold -w1<<<${wholeFile[$i]}) #fold works here bc sort needs newlines
    firstArrSortUniq=$(sort -u <<<$firstArr)
    secondArr=$(fold -w1<<<${wholeFile[$i+1]}) #fold works here bc sort needs newlines
    secondArrSortUniq=$(sort -u <<<$secondArr)
    thirdArr=$(fold -w1<<<${wholeFile[$i+2]}) #fold works here bc sort needs newlines
    thirdArrSortUniq=$(sort -u <<<$thirdArr)

    commonLetter1=$(grep -o "$firstArrSortUniq" <<< "$secondArrSortUniq")
    commonLetter2=$(grep -o "$thirdArrSortUniq" <<< "$commonLetter1") #can also use comm command here: comm -1 -2 <($firstArrSortUniq) <$(secondArrSortUniq)

    if [[  $str =~ "$commonLetter2" ]]; then
        upCase=$(tr [:lower:] [:upper:]<<<$commonLetter2)
        val=$(printf "%d" "'$upCase")
        ((val = val - 64))
        (( sum = val + sum))
    else
        val=$(printf "%d" "'$commonLetter2")
        ((val = val - 38))
        (( sum = val + sum))
    fi


    ((i = i + 3))
done
echo Part A: $sum

# /////////////////////////////////////////////////////////////////////////////
fi
