#!/bin/bash
# Building Hadoop

# System updates and installing some useful tools
echo "###################################################### Starting System Update ########################################"
sudo apt-get update
echo "UPDATE DONE #################################################"
sudo apt-get -y upgrade
echo "UPGRADE DONE #################################################"
sudo apt-get -y install wget curl rsync openssh-server openssh-client software-properties-common
sudo apt install psmisc make python3-pip
echo "INSTALL DONE ###################################################"
sudo apt-get update --allow-unauthenticated --allow-insecure-repositories
echo "###################################################### Ending System Update ########################################"

# Installing java
echo "###################################################### Starting Java Installation ########################################"
sudo wget https://files-cdn.liferay.com/mirrors/download.oracle.com/otn-pub/java/jdk/8u221-b11/jdk-8u221-linux-x64.tar.gz
tar -xvzf jdk-8u221-linux-x64.tar.gz
mv jdk1.8.0_221/ java
rm -r jdk-8u221-linux-x64.tar.gz

cd /home/hsk

sudo echo 'export JAVA_HOME=/home/hsk/java' >> ~/.bashrc 
sudo echo 'export PATH=$PATH:/home/hsk/java/bin' >> ~/.bashrc 

# Java environment variables
sudo update-alternatives --install "/usr/bin/java" "java" "/home/hsk/java/bin/java" 1
sudo update-alternatives --config java
sudo update-alternatives --install "/usr/bin/javac" "javac" "/home/hsk/java/bin/javac" 1
sudo update-alternatives --config javac
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/home/hsk/java/bin/javaws" 1
sudo update-alternatives --config javaws
sudo update-alternatives --set java /home/hsk/java/bin/java

echo "###################################################### Java Done ########################################"

# disabling firewall if running
echo "###################################################### Firewall disabling ########################################"
# ufw disable
echo "###################################################### Firewall disabled ########################################"

# Defining the ssh for hadoop to use
echo "###################################################### Starting ssh ########################################"
service ssh restart

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod og-wx ~/.ssh/authorized_keys

apt-get update
echo "###################################################### ssh and system update confirmation done ########################################"

# Installing Hadoop
echo "###################################################### Starting Hadoop Installation ########################################"
cd /home/hsk
sudo wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz
tar -xvzf hadoop-3.3.1.tar.gz
mv hadoop-3.3.1/ hadoop
rm -r hadoop-3.3.1.tar.gz

# Disabling ipv6
echo 'net.ipv6.conf.all.disable_ipv6=1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6=1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.lo.disable_ipv6=1' >> /etc/sysctl.conf

cd /home/hsk/hadoop/etc/hadoop

# Defining some hadoop environment variables
echo 'export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true' >> hadoop-env.sh
echo 'export JAVA_HOME=/home/hsk/java' >> hadoop-env.sh
echo 'export HADOOP_HOME_WARN_SUPPRESS="TRUE"' >> hadoop-env.sh
echo 'export HADOOP_ROOT_LOGGER="WARN,DRFA"' >> hadoop-env.sh

echo 'export HDFS_NAMENODE_USER="root"' >> hadoop-env.sh
echo 'export HDFS_DATANODE_USER="root"' >> hadoop-env.sh
echo 'export HDFS_SECONDARYNAMENODE_USER="root"' >> hadoop-env.sh
echo 'export YARN_RESOURCEMANAGER_USER="root"' >> hadoop-env.sh
echo 'export YARN_NODEMANAGER_USER="root"' >> hadoop-env.sh

# Moving hadoop .xml files to /hadoop/etc/hadoop/
cd /home/hsk/src

cp core-site.xml /home/hsk/hadoop/etc/hadoop/
cp yarn-site.xml /home/hsk/hadoop/etc/hadoop/
cp hdfs-site.xml /home/hsk/hadoop/etc/hadoop/
cp mapred-site.xml /home/hsk/hadoop/etc/hadoop/

# Making the tmp, namenode, datanode
cd /home/hsk/hadoop
mkdir tmp/
mkdir -p /home/hsk/hadoop/yarn_data/hdfs/namenode/
mkdir -p /home/hsk/hadoop/yarn_data/hdfs/datanode/

# Refreshing the bashrc to take effect
source ~/.bashrc

# Removing anything from hdfs
rm -Rf /home/hsk/hadoop/tmp/*
rm -Rf /home/hsk/hadoop/yarn_data/hdfs/namenode/*
rm -Rf /home/hsk/hadoop/yarn_data/hdfs/datanode/*

# Formatting the namenode
hdfs namenode -format -force
echo "###################################################### Ending Hadoop Instllation ########################################"