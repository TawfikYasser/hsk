#!/bin/bash
# Starting jupyter-lab server


# Run jupyter-lab server
echo "###################################################### Starting jupyter-lab ########################################"
sudo -E env PATH="${PATH}" SPARK_HOME="${SPARK_HOME}" PYSPARK_SUBMIT_ARGS="${PYSPARK_SUBMIT_ARGS}" jupyter-lab --ip 0.0.0.0 --allow-root &
