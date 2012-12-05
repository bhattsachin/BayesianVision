#!/bin/sh
#creates files with same suffix into different folder

for file in test/*.*
do
    foldernum=`echo $file | grep -P "\d+" -o`
    echo $foldernum
    basefile=`basename $file`
    dirfile=`dirname $file`
    
    #check if dir exists
    if [ -d "test/$foldernum" ]
    then
        
        echo "exists"
    else
        `mkdir "$dirfile/$foldernum"`
        echo "created"
    fi
    `mv "$file" "$dirfile/$foldernum/$basefile"`

done