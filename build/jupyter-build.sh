#!/bin/bash
# Building Spark

cd /home/hsk

# Installing jupyter-lab
echo "###################################################### jupyter-lab Installation Start ########################################"
sudo apt install -y python3-pip python3-dev
sudo pip install jupyterlab
echo "###################################################### jupyter-lab Installation Finish ########################################"
