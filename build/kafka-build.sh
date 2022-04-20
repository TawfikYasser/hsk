#!/bin/bash
# Building Kafka

cd /home/hsk

# Installing Zookeeper
echo "###################################################### Starting Zookeeper Installation ########################################"
sudo wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
tar -xvzf zookeeper-3.4.6.tar.gz
mv zookeeper-3.4.6/ zookeeper/
rm -r zookeeper-3.4.6.tar.gz
echo "###################################################### Ending Zookeeper Installation ########################################"

# For Zookeeper
echo "###################################################### Starting Zookeeper Confs ########################################"
mkdir zkData/

ls

# Zookeeper confs
cd home/hsk/zookeeper/conf

cat <<\EOF >> /home/hsk/zookeeper/conf/zoo.cfg
tickTime=2000
dataDir=/home/hsk/zkData
clientPort=2181
EOF

echo "###################################################### Ending Zookeeper Confs ########################################"
cd /home/hsk

# Installing Kafka
echo "###################################################### Starting Kafka Installation ########################################"
wget https://dlcdn.apache.org/kafka/3.1.0/kafka_2.12-3.1.0.tgz
tar -xzvf kafka_2.12-3.1.0.tgz
mv kafka_2.12-3.1.0/ kafka/ 
rm -r kafka_2.12-3.1.0.tgz
mkdir kafka-logs/
echo "###################################################### Ending Kafka Installation ########################################"

echo "All builds are done"