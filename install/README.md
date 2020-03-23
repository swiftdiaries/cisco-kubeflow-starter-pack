# Installation Instructions

This directory contains the instructions for installing Kubeflow. 

## Prerequisites

- UCS C240
	* Ubuntu 16+
	* Kubernetes v1.14.x
	* Default Kubernetes storage class that can dynamically provision volumes

### [Internal] Kubernetes reference
Here's a  reference [guide](k8sup.md) for creating a test Kubernetes cluster with a dynamic storage class. <br>
**Note:** This guide is meant for internal development and testing. And serves as a reference for kubeflow-starter-pack users and not as a recommended setup instructions for Kubernetes.

## Installation

- [Kubeflow](#kubeflow)

## <a id=kubeflow></a> Install Kubeflow
	export INGRESS_IP=<UCS Machine's IP>
	sh kubeflowup.sh

Check if all Kubeflow components are running successfully

	kubectl get pods --all-namespaces
