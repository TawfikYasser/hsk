# hsk

![HSK IMAGE](/hsk_header.png)

Docker of {Hadoop, Spark, Kafka}

## Docker Image for running Hadoop, Spark, and Kafka on the same node.

### Versions

- Hadoop: 3.3.1
- Java: 11.0.13
- Spark: 3.3.1
- Kafka: 2.12-3.3.1
- Zookeeper: 3.4.6
- Python: latest (for Ubuntu: 22.04)
- JupyterLab: latest

Based on a docker image: `Ubuntu:22.04`

### Attached files

- build files: used to build the image.
- src files: belongs to hadoop installation.
- start files: launchers for Kafka, Hadoop, JupyterLab.
- bin files: contains sample examples for running hadoop/spark/kafka
- hsk-build-log.txt: shows the full log for the build process.
- hsk-inspection.json: the inspection of the image.

### Run from docker hub

```bash
docker run --network=host -dit --name hskj alekseygur/hskj
```

### Build manually

```bash
docker build -t hskj:latest .
```

### Run

```bash
docker run --network=host -dit --name hskj hskj
```

### Using JupyterLab

Visit page with code example hdfs+spark+kafka: [http://localhost:8888/lab/tree/example.ipynb](http://localhost:8888/lab/tree/example.ipynb)

Password: admin

### Using python

Every script that uses pyspark [should](https://stackoverflow.com/questions/34998433/create-pyspark-kernel-for-jupyter) starts from this:

```bash
import findspark
findspark.init()
```
