#!/bin/bash

# 定义文件数量
n=1000

for ((i=1; i<=n; i++))
do
    touch "/home/netlab/test_inotify/data/${i}.txt"
    echo "Created ${i}.txt"
done

for ((i=1; i<=n; i++))
do
    echo 'hello linux' >> "/home/netlab/test_inotify/data/${i}.txt"
    echo "Modify ${i}.txt"
done

for ((i=n; i>=1; i--))
do
    rm "/home/netlab/test_inotify/data/${i}.txt"
    echo "Deleted ${i}.txt"
done