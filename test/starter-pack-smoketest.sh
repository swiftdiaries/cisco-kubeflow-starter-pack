#!/bin/bash
sudo apt install nfs-kernel-server
cd $GITHUB_WORKSPACE/apps/networking/ble-localization/onprem/install/
sh nfs-installation.sh
