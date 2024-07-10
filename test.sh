#!/bin/bash
currDir="/home/netlab/test_inotify"
outputFile="$currDir/output.log"

srceventPrefix="$currDir/data"
targeteventPrefix="$currDir/targetData"
srceventPrefixLen=${#srceventPrefix}
targeteventPrefixLen=${#targeteventPrefix}

formatArrLen=3

rm -rf ${srceventPrefix}/*
rm -rf ${targeteventPrefix}/*
> ${outputFile}

while IFS= read -r event; do
    read -a arr <<< "$event"
    if [ ${#arr[@]} != $formatArrLen ]; then
        continue
    fi
    
    changePath=${arr[0]}
    changeType=${arr[1]}
    changeFile=${arr[2]}

    targetChangePath="${targeteventPrefix}${changePath:${srceventPrefixLen}}"
    
    srcChangeFile="${changePath}${changeFile}"
    targetChangeFile="${targetChangePath}${changeFile}"

    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] changePath: ${changePath}; changeType: ${changeType}; changeFile: ${changeFile}" >> $outputFile

    if [ ${changeType} == "CREATE" ]; then
        if [ -f ${srcChangeFile} ]; then
            cp ${srcChangeFile} ${targetChangePath}
        fi
    elif [ ${changeType} == "DELETE" ]; then
        if [ -f ${targetChangeFile} ]; then
            rm ${targetChangeFile}
        fi
    elif [ ${changeType} == "MODIFY" ]; then
        if [ -f ${srcChangeFile} ]; then
            diff --unified ${targetChangeFile} ${srcChangeFile} | patch ${targetChangeFile}
        fi
    fi

done < <(inotifywait -rme modify,move,create,delete,delete_self ${srceventPrefix})