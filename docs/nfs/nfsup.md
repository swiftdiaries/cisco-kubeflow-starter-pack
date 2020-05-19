# Install NFS Dynamic Volume Provisioner

Please ensure that K8s & Kubeflow is already installed.

- [NFS Dynamic Storage Class](#nfs)
    * [Install NFS dynamic volume provisioner](#nfs-helm-package)
    * [Create volume claims](#create-nfs-volumeclaims)

## <a id=nfs></a> Install NFS Dynamic Storage Class

### <a id=nfs-helm-package></a> Install NFS dynamic volume provisioner
With [Helm](https://helm.sh/docs/intro/install/) installed on the UCS machine run:

```bash
helm repo update
helm install stable/nfs-server-provisioner --name kf --set=persistence.enabled=true,persistence.storageClass=local-path,persistence.size=50Gi
```

> Note: Replace `storageClass` with the relevant default Storage Class in your k8s cluster.

### <a id=create-nfs-volumeclaims></a> Create volume claims

```bash     
cd ${PROJECT_ROOT_DIR}/apps/networking/ble-localization/install/
kubectl create secret generic kubeflow-dashboard-ip  --from-literal=KUBEFLOW_DASHBOARD_IP=$INGRESS_IP  -n kubeflow
kubectl create -f nfs/anonymous-profile.yaml
kubectl create -f nfs/anonymous/nfs-pvc.yaml
kubectl create -f nfs/kubeflow/nfs-pvc.yaml
```

This will create:

- A k8s secret with the `$INGRESS_IP` in the kubeflow namespace
- An anonymous user profile
- nfs-pvc in anonymous, kubeflow namespaces
