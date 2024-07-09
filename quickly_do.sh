#!/bin/bash

# 定义文件数量
n=1000

# 创建文件，从1到n
for ((i=1; i<=n; i++))
do
    touch "/home/netlab/test_inotify/data/${i}.txt"
    echo "Created ${i}.txt"
done

# 删除文件，从n到1
for ((i=n; i>=1; i--))
do
    rm "/home/netlab/test_inotify/data/${i}.txt"
    echo "Deleted ${i}.txt"
done