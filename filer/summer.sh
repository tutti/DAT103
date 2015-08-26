#!/bin/bash
code=0
sum=0
echo "Skriv inn tall separert av enter:"
while [ $code -eq 0 ]; do
    read input
    code=$?
    sum=$((sum + input))
done
echo "Summen av tallene:"
echo $sum