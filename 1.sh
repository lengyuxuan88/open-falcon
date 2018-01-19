#!/bin/sh
dimm_num=`hpasmcli -s "show dimm" | grep Processor | wc -l`

Processor=(`hpasmcli -s "show dimm" | grep Processor | awk  '{print $1"_"$3}'`)
#for i in ${Processor[@]}
#do
#echo $i
#done

Module=(`hpasmcli -s "show dimm" | grep Module | awk '{print $1"_"$3}'`)
#for var in ${Module[@]}
#do
#echo $var
#done

res=$(
for ((i=0;i<$dimm_num;i++))
do
    echo ${Processor[$i]}_${Module[$i]}
done
)

echo "$res"
