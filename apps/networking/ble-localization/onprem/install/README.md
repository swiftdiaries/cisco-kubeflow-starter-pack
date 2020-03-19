## Installation

Please ensure that K8s & Kubeflow was already installed from [here](./../../../../../install) 
before executing app instructions

- [NFS and it's PV and PVC](#nfs)
  * [NFS apt package](#nfs-apt-package)
  * [Run nfs-installation.sh](#run-nfs-installationsh)
  * [Provide UCS Cluster IP](#ucs-cluster-ip)
  
## <a id=nfs></a> Install NFS and it's PV and PVC

### <a id=nfs-apt-package></a> Install NFS apt package
With sudo access on the UCS machine run:

	sudo apt install nfs-kernel-server
	
### <a id=run-nfs-installationsh></a> Run nfs-installation.sh 

     sh nfs-installation.sh

### <a id=ucs-cluster-ip></a> Provide UCS Cluster IP

	 $ sh nfs-installation.sh
	 Provide INGRESS_IP (ex: 10.10.10.101)
	 INGRESS IP:

This script will create ClusterRoleBinding, create secrets, create nfs-server, nfs-pv, nfs-pvc in anonymous, kubeflow namespaces.
