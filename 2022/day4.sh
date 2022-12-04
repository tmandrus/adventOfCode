#!/usr/bin/env bash

file=day4.dat
part=2

if [[ ${part} -eq 1 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 1 0.55s // 463
sed 's/-/ /g' $file > $file.tmp
sum=0
while IFS=, read -r range1 range2 || [[ -n ${range1} ]]; do
    ranges=($(echo $range1 $range2))
    if [[ ${ranges[2]} -le ${ranges[0]} && ${ranges[3]} -ge ${ranges[1]} ]]; then
        ((sum = sum + 1))
        continue #mandatory to make sure we don't double count somehow
    fi

    if [[ ${ranges[0]} -le ${ranges[2]} && ${ranges[1]} -ge ${ranges[3]}  ]]; then
        ((sum = sum + 1))
        continue
    fi
done < $file.tmp

echo Part 1: $sum
# /////////////////////////////////////////////////////////////////////////////
fi

if [[ ${part} -eq 2 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 2  0.54s // 919
sed 's/-/ /g' $file > $file.tmp
sum=0
while IFS=, read -r range1 range2 || [[ -n ${range1} ]]; do
    ranges=($(echo $range1 $range2))
    if [[ ${ranges[2]} -le ${ranges[0]} && ${ranges[0]} -le ${ranges[3]} ]]; then
        # echo overlap
        # echo ${ranges[@]}
        ((sum=sum+1))
        continue
    fi

    # if [[ ${ranges[2]} -le ${ranges[1]} && ${ranges[1]} -le ${ranges[3]} ]]; then
    #     # echo overlap
    #     # echo ${ranges[@]}
    #     ((sum=sum+1))
    #     continue
    # fi

    if [[ ${ranges[0]} -le ${ranges[2]} && ${ranges[2]} -le ${ranges[1]} ]]; then
        # echo overlap
        # echo ${ranges[@]}
        ((sum=sum+1))
        continue
    fi


    # if [[ ${ranges[0]} -le ${ranges[3]} && ${ranges[3]} -le ${ranges[1]} ]]; then
    #     # echo overlap
    #     # echo ${ranges[@]}
    #     ((sum=sum+1))
    #     continue
    # fi

done < $file.tmp

echo Part 2: $sum
# /////////////////////////////////////////////////////////////////////////////
fi

rm $file.tmp