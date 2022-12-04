#!/bin/bash
# Starting jupyter-lab server


# Run jupyter-lab server
echo "###################################################### Starting jupyter-lab ########################################"
sudo jupyter-lab --ip 0.0.0.0 --allow-root &
jupyter-lab list
