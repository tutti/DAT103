#!/bin/bash

# Når programmet starter, starter det en "filkontroll.sh"-prosess for hver fil
# som skal overvåkes. Output fra alle disse filene omdirigeres til samme fil.
# PIDene til disse prosessene lagres midlertidig. Etter å ha startet alle disse,
# startes en enkel tail -f som overvåker denne filen, og outputter endringer til
# terminal. Dette hindrer programmet i å gå videre, siden denne avsluttes med
# Ctrl+C. For å avslutte de andre prosessene, fanges Ctrl+C opp og brukes til å
# avslutte disse, før programmet avsluttes.

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