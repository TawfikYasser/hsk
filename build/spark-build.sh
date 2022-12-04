#!/bin/bash
# Building Spark

cd /home/hsk

# Installing Spark
echo "###################################################### Starting Spark Installation ########################################"
sudo wget https://archive.apache.org/dist/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz
tar -xvzf spark-3.2.1-bin-hadoop3.2.tgz
mv spark-3.2.1-bin-hadoop3.2/ spark/
rm -r spark-3.2.1-bin-hadoop3.2.tgz
echo "###################################################### Ending Spark Installation ########################################"

# Installing Python
echo "###################################################### Starting Python Installation ########################################"
sudo apt install -y python3 python3-pip python3-dev # changed to default python3 because 3.7 can cause conflicts
# sudo wget https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tgz
# tar -xvzf Python-3.7.12.tgz
# vrm -r Python-3.7.12.tgz
echo "###################################################### Ending Python Installation ########################################"
# Confs for Spark
echo "###################################################### Starting Spark confs ########################################"
# sudo killall apt apt-get
# sudo rm /var/lib/apt/lists/lock
# sudo rm /var/cache/apt/archives/lock
# sudo rm /var/lib/dpkg/lock*
# sudo dpkg --configure -a
sudo apt update
sudo apt install build-essential

# cd /home/hsk/Python-3.7.12/
# sudo ./configure --enable-optimizations
# sudo apt install make
# sudo make altinstall
echo "###################################################### Ending Spark confs ########################################"

# Installing pip and pyspark
echo "###################################################### Starting Pip and PySpark Installation ########################################"
python3-pip install pyspark
echo "###################################################### Ending Pip and PySpark Installation ########################################"

