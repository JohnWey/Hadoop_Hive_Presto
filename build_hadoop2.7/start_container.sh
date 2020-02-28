#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
sudo docker rm -f hadoop2-bimaster &> /dev/null
echo "start hadoop2-bimaster container..."
sudo docker run -itd \
                --net=hadoop2 \
                -p 9990:9000 \
                -p 59970:50070 \
                -p 18988:18088 \
                --name hadoop2-bimaster \
                --hostname hadoop2-bimaster \
                bidw/hadoop:base_v2.0 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop2-bislaver0$i &> /dev/null
	echo "start hadoop2-bislaver0$i container..."
	sudo docker run -itd \
	                --net=hadoop2 \
	                --name hadoop2-bislaver0$i \
	                --hostname hadoop2-bislaver0$i \
	                bidw/hadoop:base_v2.0 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop2-bimaster bash
