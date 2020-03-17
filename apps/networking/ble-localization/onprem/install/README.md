## Prerequisites

- UCS C240
	* Ubuntu 18.04 LTS
	* Kubernetes v1.14.x
	* Default Kubernetes storage class that can dynamically provision volumes

### [Optional] Prerequisites setup guide
Here's a [guide](k8sup.md) for creating a test Kubernetes cluster with a dynamic storage class. <br>
**Note:** This guide is meant for development and testing environments.

## Installation

- [Kubeflow](#kubeflow)
- [NFS and it's PV and PVC](#nfs)
  * [NFS apt package](#nfs-apt-package)
  * [Run nfs-installation.sh](#run-nfs-installationsh)
  * [Provide UCS Cluster IP](#ucs-cluster-ip)

## <a id=kubeflow></a> Install Kubeflow 

	sh kubeflowup.sh

Check if all Kubeflow components are running successfully

	kubectl get pods --all-namespaces

## <a id=nfs></a> Install NFS and it's PV and PVC

### <a id=nfs-apt-package></a> Install NFS apt package
With sudo access on the UCS machine run:

	sudo apt install nfs-kernel-server
	
### <a id=run-nfs-installationsh></a> Run nfs-installation.sh 

     sh nfs-installation.sh

### <a id=ucs-cluster-ip></a> Provide UCS Cluster IP

	 $ sh nfs-installation.sh
	 Provide UCS Cluster IP (ex: 10.10.10.101)
	 UCS Cluster IP:

This script will create ClusterRoleBinding, create secrets, create nfs-server, nfs-pv, nfs-pvc in anonymous, kubeflow namespaces.
