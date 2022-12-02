#!/usr/bin/env bash

file=day2.dat
part=2

if [[ ${part} -eq 1 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 1 0.13s

score=0
urPick=0
opPick=0
#   -- read file, check outcome
while read -r line || [[ -n "${line}" ]]; do

#   -- get points for just picking something
    if [[ "{$line:3:1}" =~ "X" ]]; then
        urPick=1
    elif [[ "{$line:3:1}" =~ "Y" ]]; then
        urPick=2
    else
        urPick=3
    fi

#   -- winning plays
#   -- rock (X) beats scissors (C), paper (Y) beats rock (A), scissors (Z) beat paper (B) | rock = 1 pt, paper = 2, scissors =3
    if [[ "${line}" =~ "C X" || "${line}" =~ "A Y" || "${line}" =~ "B Z" ]]; then
        (( score = score + 6 + urPick ))
    elif [[ "${line}" =~ "A X" || "${line}" =~ "B Y" || "${line}" =~ "C Z" || "${line}" =~ "Z C" || "${line}" =~ "Y B" || "${line}" =~ "X A" ]]; then
        (( score = score + urPick + 3 ))
    else
        (( score = score + urPick ))
    fi

done < ${file}

echo Part A $score
# /////////////////////////////////////////////////////////////////////////////
fi

if [[ ${part} -eq 2 ]]; then
# /////////////////////////////////////////////////////////////////////////////
#part 2 0.08s
score=0
outcome=0
opPick=0
#   -- read file, check outcome
while read -r line || [[ -n "${line}" ]]; do

#   -- get points for just picking something
    if [[ "{$line:3:1}" =~ "X" ]]; then
        outcome=1 
    elif [[ "{$line:3:1}" =~ "Y" ]]; then
        outcome=2
    else
        outcome=3
    fi

#   -- do whatever outcome is
    if [[ $outcome -eq 1 ]]; then #lose
        if [[ "{$line:1:1}" =~ "A" ]]; then
            urPick=3
        elif [[ "{$line:1:1}" =~ "B" ]]; then
            urPick=1
        else
            urPick=2
        fi
        (( score = score + urPick ))
    fi

    if [[ $outcome -eq 2 ]]; then #draw
        if [[ "{$line:1:1}" =~ "A" ]]; then
            urPick=1
        elif [[ "{$line:1:1}" =~ "B" ]]; then
            urPick=2
        else
            urPick=3
        fi
        (( score = score + urPick + 3 ))
    fi

    if [[ $outcome -eq 3 ]]; then #win
        if [[ "{$line:1:1}" =~ "A" ]]; then
            urPick=2
        elif [[ "{$line:1:1}" =~ "B" ]]; then
            urPick=3
        else
            urPick=1
        fi
        (( score = score + 6 + urPick ))
    fi

done < ${file}

echo Part B $score

# /////////////////////////////////////////////////////////////////////////////
fi