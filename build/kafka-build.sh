#!/bin/bash
# Building Kafka

cd /home/hsk

# Installing Zookeeper
echo "###################################################### Starting Zookeeper Installation ########################################"
sudo wget https://archive.apache.org/dist/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0.tar.gz
tar -xvzf apache-zookeeper-3.8.0.tar.gz
mv apache-zookeeper-3.8.0/ zookeeper/
rm apache-zookeeper-3.8.0.tar.gz
echo "###################################################### Ending Zookeeper Installation ########################################"

# For Zookeeper
echo "###################################################### Starting Zookeeper Confs ########################################"
mkdir zkData/

# Zookeeper confs
cd /home/hsk/zookeeper/conf

cat <<\EOF >> /home/hsk/zookeeper/conf/zoo.cfg
tickTime=2000
dataDir=/home/hsk/zkData
clientPort=2181
EOF

echo "###################################################### Ending Zookeeper Confs ########################################"
cd /home/hsk

# Installing Kafka
echo "###################################################### Starting Kafka Installation ########################################"
wget https://archive.apache.org/dist/kafka/3.3.1/kafka_2.12-3.3.1.tgz
tar -xzvf kafka_2.12-3.3.1.tgz
mv kafka_2.12-3.3.1/ kafka/ 
rm kafka_2.12-3.3.1.tgz
mkdir kafka-logs/

# need for standalone server
echo "listeners=PLAINTEXT://localhost:9092" >> /home/hsk/kafka/config/server.properties

# setup paths
sudo echo 'export PATH=$PATH:/home/hsk/kafka/bin' >> ~/.bashrc 

echo "###################################################### Ending Kafka Installation ########################################"

echo "All builds are done"
