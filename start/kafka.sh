#!/bin/bash
# Starting standalone Kafka

echo "listeners=PLAINTEXT://localhost:9092" >> ./kafka/config/server.properties  

/home/hsk/zookeeper/bin/zkServer.sh start
/home/hsk/kafka/bin/kafka-server-start.sh -daemon /home/hsk/kafka/config/server.properties
