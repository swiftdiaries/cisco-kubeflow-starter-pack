# Cisco Kubeflow Starter Pack
The Cisco Kubeflow Starter Pack is a set of end-to-end applications that uses [Kubeflow](https://www.kubeflow.org/) to manage a portable, distributed, and scalable machine learning system on on-premise [Kubernetes](https://kubernetes.io/) clusters running on Cisco ML servers. Our mission is to help Cisco customers to reduce the friction in managing ML infrastructure by eliminating the complex steps in *build-train-deploy* machine learning models.

## Cisco and Kubeflow
[Kubeflow](https://www.kubeflow.org/) is a machine learning toolkit for Kubernetes. It consists of a core set of components needed to develop, build, train, and deploy models on [Kubernetes](https://kubernetes.io/) efficiently. Cisco has been part of the Kubeflow journey since the project’s formative stage and has been one of the leading contributors with a focus on our customer needs.

## Installation
This repository needs to be cloned and the instructions in the following directories need to be followed:

- [install](./install) - This directory contains Kubernetes and Kubeflow installation instructions. These instructions should be followed to setup the base system first, before installing individual apps.

- [apps](./apps) - This directory contains apps from different verticals with each vertical being in a separate sub-folder. New apps across verticals will be regularly added. Each app has its own installation instructions that need to be followed *after* the base system has been setup. The instructions for how to use the app are also contained here.

## Getting Help
If you have questions, concerns, bug reports, etc., please create an issue against this repository. Before filing a new issue, do check if the issue has already been reported. You can also send email to the core group at *cisco-kubeflow-support AT cisco.com*.

## Getting Involved
We encourage everyone to provide us with feedback and suggest features that are high on their priority list.

## Licensing Information
Please look at the [LICENSE](./LICENSE) and [NOTICE](./NOTICE) files.

## Credits and References
1. Cisco Blog: [#consistentAI: Lessons from our Journey to Kubeflow 1.0](https://blogs.cisco.com/cloud/consistentai-lessons-from-our-journey-to-kubeflow-1-0)
2. [Kubeflow](https://www.kubeflow.org/)
3. [Kubernetes](https://kubernetes.io/)
