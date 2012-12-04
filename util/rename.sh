#!/bin/sh
# photo*.jpg bell*.jpg
for file in ../training/raw/*\ *
do
 echo "name is: $file"
 
 newname=`echo $file | sed 's/ /_/g'`
 echo "new name: $newname" 

 mv "$file" $newname
done
