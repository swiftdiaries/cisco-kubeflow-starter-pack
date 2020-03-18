#!/bin/bash

KF_APP=kf-app
mkdir -p ${KF_APP}
cd ${KF_APP}
wget -O kfctl.tar.gz https://github.com/kubeflow/kfctl/releases/download/v1.0/kfctl_v1.0-0-g94c35cf_linux.tar.gz
tar -zxvf kfctl.tar.gz
chmod +x kfctl
wget -O kfctl_k8s_istio.yaml https://raw.githubusercontent.com/kubeflow/manifests/v1.0-branch/kfdef/kfctl_k8s_istio.v1.0.0.yaml
./kfctl apply -V -f kfctl_k8s_istio.yaml
