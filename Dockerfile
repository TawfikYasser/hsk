# Using ubuntu version 22.04
FROM ubuntu:22.04

USER root

# Go to /home/hsk (create and change directory)
WORKDIR /home/hsk

# Defining some environment variables for hadoop build
ENV JAVA_HOME=/home/hsk/java
ENV JUPYTER_HOME=/home/hsk/jupyter
ENV HADOOP_HOME=/home/hsk/hadoop
ENV SPARK_HOME=/home/hsk/spark
ENV HADOOP_CONF_DIR=/home/hsk/hadoop/etc/hadoop
ENV HADOOP_MAPRED_HOME=/home/hsk/hadoop
ENV HADOOP_COMMON_HOME=/home/hsk/hadoop
ENV HADOOP_HDFS_HOME=/home/hsk/hadoop
ENV YARN_HOME=/home/hsk/hadoop
ENV HADOOP_COMMON_LIB_NATIVE_DIR="${HADOOP_HOME}/lib/native"
ENV HADOOP_OPTS="-Djava.library.path=${HADOOP_HOME}/lib"
ENV PYSPARK_SUBMIT_ARGS="--master local --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.1 pyspark-shell"

ENV PATH="/home/hsk/java/bin:${PATH}"
ENV PATH="/home/hsk/hadoop/bin:${PATH}"
ENV PATH="/home/hsk/hadoop/sbin:${PATH}"
ENV PATH="/home/hsk/kafka/bin:${PATH}"

# Copying the build files into the image
COPY /build/hadoop-build.sh /home/hsk/
COPY /build/spark-build.sh /home/hsk/
COPY /build/kafka-build.sh /home/hsk/
COPY /build/jupyter-build.sh /home/hsk/

# Copying launchers into the image
COPY /start/hadoop.sh /home/hsk/start/
COPY /start/kafka.sh /home/hsk/start/
COPY /start/jupyter.sh /home/hsk/start/
COPY /start/all.sh /home/hsk/start/

# Copyting the hadoop site files into the image
COPY /src/core-site.xml /home/hsk/src/
COPY /src/hdfs-site.xml /home/hsk/src/
COPY /src/mapred-site.xml /home/hsk/src/
COPY /src/yarn-site.xml /home/hsk/src/
COPY /src/yarn-site.xml /home/hsk/src/

# Copyting the test data
COPY /src/db.csv /home/hsk/jupyter/
COPY /src/example.ipynb /home/hsk/jupyter/

# Making hadoop-build.sh, spark-build.sh, kafka-build.sh excutables
RUN chmod +x hadoop-build.sh
RUN chmod +x spark-build.sh
RUN chmod +x kafka-build.sh
RUN chmod +x jupyter-build.sh

# Making launchers excutables
RUN chmod +x start/all.sh
RUN chmod +x start/hadoop.sh
RUN chmod +x start/kafka.sh
RUN chmod +x start/jupyter.sh

# Installing apps
RUN apt update && apt -y -qq install sudo supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Running the build files to install Hadoop, Spark, Kafka
# Checking the version of Java and Python3
RUN bash ./hadoop-build.sh
RUN java -version
RUN bash ./spark-build.sh
RUN python3 --version
RUN bash ./kafka-build.sh
RUN bash ./jupyter-build.sh

# external port
# EXPOSE 8888

# Using the bash open bash on the run of the container
# ENTRYPOINT [ "/bin/bash", "-c" ]
# CMD ["bash", '/start/all.sh']

# Using supervisord to launch many apps in the container
ENTRYPOINT ["/usr/bin/supervisord"]
