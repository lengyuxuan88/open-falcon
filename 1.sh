#!/bin/sh
p=`cat 1 | grep "Processor"| awk '{print $3}'`
#echo $p
m=`cat 1 | grep "Module" | awk '{print $3}'`   
#echo $m
echo  "$p $m" | while read n1 n2
do
    echo "Process_$n1"_"Module_$n2"
done
##echo "$p" 
##echo "$m" 
#a=`echo "$p" | awk '{print $1"_"$3}'`
#b=`echo "$m" | awk '{print $1"_"$3}'`
##echo $a
##echo $b
#for i ii in $a $b
#do
#echo $i $ii
#done

