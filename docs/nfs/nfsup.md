
# Install NFS server

Please ensure that K8s & Kubeflow is already installed.

- [NFS and it's PV and PVC](#nfs)
    * [Install NFS apt package](#nfs-apt-package)
    * [Run nfs-installation.sh](#run-nfs-installationsh)

## <a id=nfs></a> Install NFS and it's PV and PVC

### <a id=nfs-apt-package></a> Install NFS apt package
With sudo access on the UCS machine run:

	sudo apt install nfs-kernel-server
	
### <a id=run-nfs-installationsh></a> Run nfs-installation.sh 
     cd ${PROJECT_ROOT_DIR}/apps/networking/ble-localization/install/
     sh nfs-installation.sh

Sample output:<br>
```
Provide INGRESS_IP (ex: 10.10.10.101)
INGRESS IP:
```

This script will create:

- ClusterRoleBinding for NFS
- create secrets
- create nfs-server
- nfs-pv
- nfs-pvc in anonymous, kubeflow namespaces.
