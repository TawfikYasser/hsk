#!/bin/bash
# Starting standalone Kafka

while [[ "$( ps -ef | grep -i zookeeper | grep -v grep | wc -l | tr -d '\n' )" != 1 ]]; do 
    /home/hsk/zookeeper/bin/zkServer.sh start
    sleep 1
done

/home/hsk/kafka/bin/kafka-server-start.sh -daemon /home/hsk/kafka/config/server.properties
