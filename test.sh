#!/bin/bash
outputFile="/home/netlab/test_inotify/output.log"
# 启动你的程序，并将其输出通过管道传递给while循环
while IFS= read -r path; do
    # 检查输出是否为一个有效的路径
    if [ -n "$path" ]; then
        # 执行ls命令，列出该路径下的内容
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        echo "[xlc_print] [$timestamp] $path" >> $outputFile
    fi
done < <(inotifywait -rme modify,attrib,move,close_write,create,delete,delete_self /home/netlab/test_inotify/data)