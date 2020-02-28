#!/bin/bash


# start hive container
sudo docker rm -f hadoop-hive &> /dev/null
echo "start hadoop-hive container..."
sudo docker run -itd \
                --net=hadoop \
                -p 10000:10000 \
                --name hadoop-hive \
                --hostname hadoop-hive \
                bidw/hive:base_v1.0 
