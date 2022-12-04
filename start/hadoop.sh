#!/bin/bash
# Starting standalone Hadoop


# https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html
# /home/hsk/hadoop/bin/hdfs namenode -format
/home/hsk/hadoop/bin/hdfs --daemon start namenode
/home/hsk/hadoop/bin/hdfs --daemon start datanode
/home/hsk/hadoop/sbin/start-dfs.sh
/home/hsk/hadoop/bin/yarn --daemon start resourcemanager
/home/hsk/hadoop/bin/yarn --daemon start nodemanager
/home/hsk/hadoop/bin/yarn --daemon start proxyserver
/home/hsk/hadoop/sbin/start-yarn.sh
/home/hsk/hadoop/bin/mapred --daemon start historyserver


# NameNode - http://localhost:9870 (here find hdfs port for pyspark to process files inside storage)
# ResourceManager - http://localhost:8088 
# MapReduce JobHistory Server - http://localhost:19888 
