#!/bin/sh
today=date
echo "Today is $today"


for i in `ls -a ./training/cd/*.*`  
do  

fname=`basename $i`
imgname=`echo $fname | sed 's/.txt//g'`


./colordescriptor/colorDescriptor ./training/raw/$imgname --loadRegions ./training/cd/$fname  --descriptor colormomentinvariants  --output ./training/cd/scores/$fname

echo $fname
echo $imgname



done 

