#!/bin/bash

if [ -z $UCS_CLUSTER_IP ];
then
	echo "environment variable 'UCS_CLUSTER_IP' is not set; please set it to the node's IP."
	echo "exiting script..."
	exit 1
fi

sudo swapoff -a
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=${UCS_CLUSTER_IP}
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
sleep 20
kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml
sleep 30
kubectl taint nodes --all node-role.kubernetes.io/master-
sleep 30
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
sleep 30
kubectl apply -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/master/nvidia-device-plugin.yml
kubectl patch storageclasses.storage.k8s.io local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'