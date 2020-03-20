# Installing Prerequisites


- [Docker](#docker)
- [Kubernetes](#kubernetes)
- [Create a Kubernetes cluster](#k8s-up)
    * [Create cluster with kubeadm](#kubeadm)
    * [Set KUBECONFIG](#kubeconfig)
    * [Install cluster add-ons](#add-ons)
        - [Calico](#calico)
        - [NVIDIA Device Plugin](#nvidia)
        - [Storage Class](#rancher)
- [Check cluster readiness](#k8s-ready)

## <a id=docker></a> Docker setup

Update and install common libraries
```bash
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg2
```

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
# the output should equal:
# 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y \
  containerd.io=1.2.10-3 \
  docker-ce=5:19.03.4~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:19.03.4~3-0~ubuntu-$(lsb_release -cs)
```

[Source](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker)

## <a id=kubernetes></a> Kubernetes setup

Recommended version is `v1.14.10` for Kubernetes and `v0.7.5` for Kubernetes-CNI.
Please lookup EOL for Kubernetes versions before installing.

```bash
KUBERNETES_VERSION=1.14.10
KUBERNETES_CNI=0.7.5
sudo bash -c 'apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get -y update'
sudo apt-get install -yf \
  socat \
  ebtables \
  apt-transport-https \
  kubelet=${KUBERNETES_VERSION}-00 \
  kubeadm=${KUBERNETES_VERSION}-00 \
  kubernetes-cni=${KUBERNETES_CNI}-00 \
  kubectl=${KUBERNETES_VERSION}-00
```

[Source](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

## <a id=k8s-up></a> Create a single node Kubernetes cluster

A single node Kubernetes cluster does not have ETCD replication or cluster backup. It is not suitable for production workloads.
**Recommended**: HA Kubernetes cluster with cluster backup for production.

### <a id=kubeadm></a> Create cluster with kubeadm
```bash
INGRESS_IP=<UCS machine\'s IP>
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart kubelet
sleep 30 # wait for docker, kubelet to restart
sudo swapoff -a
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=${INGRESS_IP}
```

### <a id=kubeconfig></a> Copy KUBECONFIG into userspace
```bash
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
```
#### Check KUBECONFIG

`kubectl get nodes -o wide`
|NAME               |STATUS         |ROLES      |AGE  	    |VERSION    |INTERNAL-IP |EXTERNAL-IP |OS_IMAGE             |KERNEL-VERSION     |CONTAINER-RUNTIME |
|---	            |---	        |---	    |---	    |---	    |---         |---         |---                  |---                |---               |
|ucs-kubeflow   	|Ready   	    |master   	|6d10h   	|v1.14.10   |10.x.x.1    |\<none>     |Ubuntu 18.04.2 LTS   |4.15.0-20-generic  |docker://18.9.3   |

### <a id=add-ons></a> Install cluster add-ons

#### <a id=calico></a> Calico
```bash
kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml
```

##### Taint master node, check calico pods

```bash
# tainting the master node alows pods to be scheduled on it
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl get pods -n kube-system -w
```
Ensure the coredns, calico and the kube-proxy pods are running.

#### <a id=nvidia></a> NVIDIA Device Plugin
The NVIDIA GPU device plugin runs as a Kubernetes daemonset and exposes the underlying GPUs as a usable Kubernetes resource.

```bash
kubectl apply -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/master/nvidia-device-plugin.yml
```

#### <a id=rancher></a> Storage Class
The Rancher local-path-provisioner storage class creates host-path mounted persistent-volumes for persistent-volume-claims dynamically. <br>
**Note:**
There are security concerns around host-path volumes as they expose the underlying host filesystem to Kubernetes pods and applications. Container breakouts could be dangerous.

```bash
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
# set local-path to be default storage class
kubectl patch storageclasses.storage.k8s.io local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

## <a id=k8s-ready></a> Check cluster readiness

Cluster checks:
- [ ] Kubernetes node is ready
    * `kubectl get nodes -o wide`
- [ ] Storage Class is running
    * `kubectl get pods -n local-path-storage`
- [ ] kube-system pods are running
    * `kubectl get pods -n kube-system`
