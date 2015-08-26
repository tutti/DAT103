#!/bin/bash
pids=()
ctrlc()
{
    for pid in "${pids[@]}"
    do
        kill $pid
    done
    exit
}
oldIFS=$IFS
IFS=$' '
filnavn=($@)
> kontrollflerefiler.txt
for fil in "${filnavn[@]}"
do
    bash filkontroll.sh $fil 60 >> kontrollflerefiler.txt &
    pids+=($!)
done
IFS=$oldIFS
trap ctrlc SIGINT
tail -f kontrollflerefiler.txt