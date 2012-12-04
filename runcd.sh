#!/bin/sh
today=date
echo "Today is $today"
txt=".txt"

#delete the old entries
echo "deleting old entries"
echo `rm ./training/cd/scores/*.*`

for i in `ls -a ./training/tmp/*.*`  
do  

fname=`basename $i`
onlyname=`echo $fname | sed 's/JPG/txt/g'`
onlyname=`echo $onlyname | sed 's/jpg/txt/g'`
onlyname=`echo $onlyname | sed 's/png/txt/g'`
imgname=`echo $fname`



./colordescriptor/colorDescriptor ./training/tmp/$imgname --detector harrislaplace --descriptor opponentsift --outputFormat binary --output ./training/cd/scores/$onlyname

echo $imgname



done 

