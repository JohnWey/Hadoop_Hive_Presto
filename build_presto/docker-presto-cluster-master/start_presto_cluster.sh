#!/bin/bash

# the default node number is 3
N=${1:-3}

# Launch coordinator container
sudo docker rm -f presto-coordinator &> /dev/null
echo "start presto-coordinator container..."
sudo docker run -itd \
                --net=presto_network \
                -p 8080:8080 \
                --name presto-coordinator \
                --hostname presto-coordinator \
                bidw/presto-coordinator http://localhost:8080


# Launch workers container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f presto-worker0$i &> /dev/null
	echo "start presto-worker0$i container..."
	sudo docker run -itd \
	                --net=presto_network \
	                -p 808$i:8081 \
	                --name presto-worker0$i \
	                --hostname presto-worker0$i \
	                bidw/presto-worker http://presto-coordinator:8080
	i=$(( $i + 1 ))
done 

# get into coordinator container
sudo docker exec -it presto-coordinator bash

