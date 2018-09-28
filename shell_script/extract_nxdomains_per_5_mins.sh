#!/bin/bash

# extract_nxdomain_per_5_mins.sh 提取nxdomains,一次提5 min的,按5 min一个文件进行存储
# author: liuzhicheng
# useage: extract_nxdomain_per_5_mins.sh

echo "input_day：$1*";

function single() # deal with raw_data in local disk
{
    # touch /mnt/Work/DNS/data/nxdomains_per_5_mins/$1/$1$2$3.txt
    awk -F ',' '{ if($16 == "MULL"){print $0} }' /mnt/Work/DNS/data/raw_data/$1$2/V4*$3.txt > /mnt/Work/DNS/data/nxdomains_per_5_mins/$1/$1$2$3.txt
}

function single1() # deal with raw_data in remote disk
{
    touch /mnt/Work/DNS/data/nxdomains_per_5_mins/$1/$1$2$3.txt
    awk -F ',' '{ if($16 == "MULL"){print $0} }' /media/lzc/liuzhichenger/data/raw_data/$1$2/V4*$3.txt > /mnt/Work/DNS/data/nxdomains_per_5_mins/$1/$1$2$3.txt
}

function parallel()
{
    date_days="20171104 20171105"              #变量名和等号之间不能有空格
    hours="00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23"
    # hours="16 17 18 19 20 21 22 23"
    # hours="00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20"
    mins="00 05 10 15 20 25 30 35 40 45 50 55"

    for day in $date_days; do
        mkdir -p /mnt/Work/DNS/data/nxdomains_per_5_mins/$day/
        for hour in $hours; do
            for min in $mins; do
                echo $day$hour$min
                single $day $hour $min
            done
        done
    done
}

parallel


