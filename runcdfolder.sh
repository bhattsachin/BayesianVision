#!/bin/sh
today=date
echo "Today is $today"
txt=".txt"

#delete the old entries
echo "deleting old entries"
echo `rm -r ./training/cd/scores/*`

for i in training/tmp/* 
do  

if [ -d "$i" ]
then
	basefolder=`basename $i`
	if [ -d "./training/cd/scores/$basefolder"]
		then
			echo "$basefolder already exists"
		else
			`mkdir "./training/cd/scores/$basefolder"`
			echo "$basefolder created"
	fi
	
	for sfolder in $i/*.*
	do

	fname=`basename $sfolder`
	onlyname=`echo $fname | sed 's/JPG/txt/g'`
	onlyname=`echo $onlyname | sed 's/jpg/txt/g'`
	onlyname=`echo $onlyname | sed 's/png/txt/g'`
	imgname=`echo $fname`

	echo "image name : $imagename"
	echo "base folder: $basefolder"
	echo "onlyname : $onlyname"


	./colordescriptor/colorDescriptor ./training/tmp/$basefolder/$imgname --detector harrislaplace --descriptor opponentsift --outputFormat binary --output ./training/cd/scores/$basefolder/$onlyname

	echo $imgname

	done
else
	echo "a file present"
fi


done 

