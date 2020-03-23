# Installation Instructions

This directory contains the instructions for installing Kubeflow. 

## Prerequisites

- UCS C240
	* Ubuntu 16+
	* Kubernetes v1.14.x
	* Default Kubernetes storage class that can dynamically provision volumes

## Installation

- [Kubeflow](#kubeflow)
	* Version: v1.0.0
	* Kubeflow manifests repo release tag: https://github.com/kubeflow/manifests/tree/v1.0.0
	* kfctl CLI release tag: https://github.com/kubeflow/kfctl/tree/v1.0 

## <a id=kubeflow></a> Install Kubeflow
	export INGRESS_IP=<UCS Machine's IP>
	sh kubeflowup.sh

Check if all Kubeflow components are running successfully

	kubectl get pods --all-namespaces
