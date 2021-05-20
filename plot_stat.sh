#!/bin/sh
LOG_FILES=~/chia/log*

for j in {1..4}
do
        i="Time for phase ${j}"
        echo -n ${i} ":"
        grep "${i}" ${LOG_FILES} | awk '{ sumX=sumX+$6 ; sumX2+=(($6)^2)} END { printf " %.3f+-%.3f\t", sumX/(NR), sqrt((sumX2-sumX^2/NR)/(NR-1)/NR)}'
        echo -n " med "
        grep "${i}" ${LOG_FILES} | awk '{ print $6 }' | sort -n | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/2; else print a[x-1]; }' | sed -z '$ s/\n$//'
        echo -n " max "
        grep "${i}" ${LOG_FILES} | awk '{ print $6 }' | sort -n | tail -1 | sed -z '$ s/\n$//'
        echo -n " min "
        grep "${i}" ${LOG_FILES} | awk '{ print $6 }' | sort -n | head -1
done
echo "-------------------------------------------------------------------------------------"
i="Total time"
echo -n ${i} ":"
grep "${i}" ${LOG_FILES} | awk '{ sumX=sumX+$4 ; sumX2+=(($4)^2)} END { printf " %.3f+-%.3f\t", sumX/(NR), sqrt((sumX2-sumX^2/NR)/(NR-1)/NR)}'
echo -n " med "
grep "${i}" ${LOG_FILES} | awk '{ print $4 }' | sort -n | awk ' { a[i++]=$1; } END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/2; else print a[x-1]; }' | sed -z '$ s/\n$//'
echo -n " max "
grep "${i}" ${LOG_FILES} | awk '{ print $4 }' | sort -n | tail -1 | sed -z '$ s/\n$//'
echo -n " min "
grep "${i}" ${LOG_FILES} | awk '{ print $4 }' | sort -n | head -1

