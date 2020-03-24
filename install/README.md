# Installation Instructions

This directory contains the instructions for installing Kubeflow. 

## Prerequisites

- UCS C240
	* Ubuntu 16+ baremetal
	* Kubernetes v1.14.x
	* Default Kubernetes storage class that can dynamically provision volumes

### [Internal] Prerequisites Reference setup

[This](k8sup.md) is a reference guide for creating a test Kubernetes cluster with a dynamic storage class. <br>

**Note:** This is not part of the kubeflow-starter-pack. It is meant for internal development and testing. This serves as a reference for kubeflow-starter-pack users and not recommended as a golden path for setting up prerequisites.

## <a id=kubeflow></a> Install Kubeflow
- Kubeflow
	* Version: v1.0.0
	* Kubeflow manifests repo release tag: https://github.com/kubeflow/manifests/tree/v1.0.0
	* kfctl CLI release tag: https://github.com/kubeflow/kfctl/tree/v1.0 
	
```
export INGRESS_IP=<UCS Machine's IP>
sh kubeflowup.sh
```

Check if all Kubeflow components are running successfully

	kubectl get pods --all-namespaces
