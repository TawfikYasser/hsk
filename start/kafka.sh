#!/bin/bash
# Starting standalone Kafka

while [[ "$( ps -ewwo cmd | grep -i zookeeper | grep -v grep | wc -l | tr -d '\n' )" != 1 ]]; do 
    /home/hsk/zookeeper/bin/zkServer.sh start
    sleep 1
done

while [[ "$( /home/hsk/kafka/bin/kafka-broker-api-versions.sh --bootstrap-server localhost:9092 | grep id | grep -v WARN | wc -l | tr -d '\n' )" != 1 ]]; do 
    /home/hsk/kafka/bin/kafka-server-start.sh -daemon /home/hsk/kafka/config/server.properties
    sleep 1
done
