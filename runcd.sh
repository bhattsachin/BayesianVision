#!/bin/sh
today=date
echo "Today is $today"
txt=".txt"

for i in `ls -a ./training/tmp/*.*`  
do  

fname=`basename $i`
onlyname=`echo $fname | sed 's/JPG/txt/g'`
imgname=`echo $fname`


./colordescriptor/colorDescriptor ./training/tmp/$imgname --detector harrislaplace --descriptor csift --outputFormat binary --output ./training/cd/scores/$onlyname

echo $imgname



done 

