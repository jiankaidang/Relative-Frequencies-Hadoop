#!/bin/sh

myflow_id=$1
input_s3=$2
output_directory=$3

#Use AWS CLI to copy jar files to input_s3 (S3)
aws s3 cp hadoop-relative-frequencies.jar $input_s3/
aws s3 cp wikitext_500.txt $input_s3/

startStripes=$(date +%s)
elastic-mapreduce -j $myflow_id --jar $input_s3/hadoop-relative-frequencies.jar --arg Stripes --arg s3://jiankaidang --arg wikitext_500.txt --arg $output_directory
elastic-mapreduce -j $myflow_id --wait-for-steps
timeStripes=$(expr $(date +%s) - $startStripes)

aws s3 cp $output_directory/rfstripes/part-r-00000 $output_directory/rfstripes.txt

#startPairs=$(date +%s)
#elastic-mapreduce -j $myflow_id --jar $input_s3/hadoop-relative-frequencies.jar --arg Pairs --arg s3://cs9223 --arg wikitext_500000.txt --arg $output_directory
#elastic-mapreduce -j $myflow_id --wait-for-steps
#timePairs=$(expr $(date +%s) - $startPairs)
#
#aws s3 cp $output_directory/rfpairs/part-r-00000 $output_directory/rfpairs.txt
#
#echo $(expr $timePairs / $timeStripes) > rfcomp-tmp.txt
#aws s3 cp rfcomp-tmp.txt $output_directory/rfcomp.txt
#rm rfcomp-tmp.txt