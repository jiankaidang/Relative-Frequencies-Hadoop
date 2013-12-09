#!/bin/sh

startStripes=$(date +%s)
hadoop jar hadoop-relative-frequencies.jar Stripes $1 $2 $3
timeStripes=$(expr $(date +%s) - $startStripes)

cat $3/rfstripes/part-r-00000 > $3/rfstripes.txt
rm -rf $3/rfstripes

startPairs=$(date +%s)
#hadoop jar hadoop-relative-frequencies.jar Pairs $1 $2 $3
timePairs=$(expr $(date +%s) - $startPairs)

#cat $3/rfpairs/part-r-00000 > $3/rfpairs.txt
#rm -rf $3/rfpairs

echo $(expr $timePairs / $timeStripes) > $3/rfcomp.txt