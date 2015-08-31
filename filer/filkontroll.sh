#!/bin/bash
filnavn=$1
intervall=$2
fil_finnes=false
siste_timestamp=0
if [ -f $filnavn ]; then
	fil_finnes=true
	siste_timestamp=`date -r $filnavn`
fi
sjekk=true
while $sjekk; do
    sleep $intervall
    if ! $fil_finnes && [ -f $filnavn ]; then
        echo "Filen $filnavn har blitt opprettet."
        siste_timestamp=`date -r $filnavn`
        fil_finnes=true
        sjekk=true
    fi
    if $fil_finnes && [ ! -f $filnavn ]; then
        echo "Filen $filnavn har blitt slettet."
        fil_finnes=false
        sjekk=true
    fi
    if $fil_finnes; then
        nytt_timestamp=`date -r $filnavn`
        if [ "$siste_timestamp" != "$nytt_timestamp" ]; then
            echo "Filen $filnavn har blitt endret."
            siste_timestamp=$nytt_timestamp
            sjekk=true
        fi
    fi
done