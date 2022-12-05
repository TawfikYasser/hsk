#!/bin/bash
# Building Spark

cd /home/hsk

# Installing jupyter-lab
echo "###################################################### jupyter-lab Installation Start ########################################"
sudo apt install -y -qq python3-pip python3-dev
sudo pip install jupyterlab

# jupyter kernelspec list
jupyter server --generate-config

mkdir -p ${JUPYTER_HOME}

# setup homefolder
echo "c.NotebookApp.notebook_dir = '${JUPYTER_HOME}'" >> /root/.jupyter/jupyter_server_config.py

# setup pass: admin
echo 'c.NotebookApp.password = "argon2:$argon2id$v=19$m=10240,t=10,p=8$ow9I3YQiWrSsvNQPBhR/ug$TwbmFUKhfKtkHnB+HgXnpshS+R5YQmDZtXP1DAuGa6s"' >> /root/.jupyter/jupyter_server_config.py


echo "###################################################### jupyter-lab Installation Finish ########################################"
