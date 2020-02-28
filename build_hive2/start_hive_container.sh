#!/bin/bash


# start hive container
sudo docker rm -f hadoop2-hive &> /dev/null
echo "start hadoop2-hive container..."
sudo docker run -itd \
                --net=hadoop2 \
                -p 19900:10000 \
                --name hadoop2-hive \
                --hostname hadoop2-hive \
                bidw/hive:base_v2.0


sudo docker exec -it hadoop2-hive bash 
