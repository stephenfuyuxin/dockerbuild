#!/bin/bash

MINICONDA_INSTALL="Miniconda3-latest-Linux-aarch64.sh"
INSTALL_DIR="${HOME}/miniconda3"

bash ${MINICONDA_INSTALL} -b -p ${INSTALL_DIR}
echo -e "\n. ~/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc

#Please, press ENTER to continue "\r"
#Do you accept the license terms? [yes|no] "yes\r"
#Miniconda3 will now be installed into this location: "\r"
#You can undo this by running `conda init --reverse $SHELL`? [yes|no] "yes\r"
