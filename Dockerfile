# Using ubuntu version 22.04
FROM ubuntu:22.04

USER root

# Go to /home/hsk (create and change directory)
WORKDIR /home/hsk

# Defining some environment variables for hadoop build
ENV JAVA_HOME="/home/hsk/java"
ENV PATH="/home/hsk/java/bin:${PATH}"
ENV HADOOP_HOME=/home/hsk/hadoop
ENV HADOOP_CONF_DIR=/home/hsk/hadoop/etc/hadoop
ENV HADOOP_MAPRED_HOME=/home/hsk/hadoop
ENV HADOOP_COMMON_HOME=/home/hsk/hadoop
ENV HADOOP_HDFS_HOME=/home/hsk/hadoop
ENV YARN_HOME=/home/hsk/hadoop
ENV PATH="/home/hsk/hadoop/bin:${PATH}"
ENV PATH="/home/hsk/hadoop/sbin::${PATH}"
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"

# Copying the build files into the image
COPY /build/hadoop-build.sh /home/hsk/
COPY /build/spark-build.sh /home/hsk/
COPY /build/kafka-build.sh /home/hsk/

# Copying launchers into the image
COPY /start /home/hsk

# Copyting the hadoop site files into the image
COPY /src/core-site.xml /home/hsk/src/
COPY /src/hdfs-site.xml /home/hsk/src/
COPY /src/mapred-site.xml /home/hsk/src/
COPY /src/yarn-site.xml /home/hsk/src/

# Making hadoop-build.sh, spark-build.sh, kafka-build.sh excutables
RUN chmod +x hadoop-build.sh
RUN chmod +x spark-build.sh
RUN chmod +x kafka-build.sh

# Installing sudo on the image
RUN apt-get update && \
      apt-get -y install sudo


# Running the build files to install Hadoop, Spark, Kafka
# Checking the version of Java and Python3
RUN bash ./hadoop-build.sh
RUN java -version
RUN bash ./spark-build.sh
RUN python3 --version
RUN bash ./kafka-build.sh

# Using the bash open bash on the run of the container
ENTRYPOINT [ "/bin/bash", "-c" ]
CMD ["bash"]
