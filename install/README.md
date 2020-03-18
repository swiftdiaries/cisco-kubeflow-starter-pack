# Installation Instructions

This directory contains the installation instructions for installing Kubernetes and
Kubeflow. Additionally, each app directory has the app-specific installation instructions.

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

## <a id=kubeflow></a> Install Kubeflow 

	sh kubeflowup.sh

Check if all Kubeflow components are running successfully

	kubectl get pods --all-namespaces
