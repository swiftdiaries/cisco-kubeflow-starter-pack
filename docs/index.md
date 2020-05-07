# Cisco Kubeflow Starter Pack
The Cisco Kubeflow Starter Pack is a set of end-to-end applications that uses [Kubeflow](https://www.kubeflow.org/) to manage a portable, distributed, and scalable machine learning system on on-premise [Kubernetes](https://kubernetes.io/) clusters running on Cisco ML servers. Our mission is to help Cisco customers to reduce the friction in managing ML infrastructure by eliminating the complex steps in *build-train-deploy* machine learning models.

## Cisco and Kubeflow
[Kubeflow](https://www.kubeflow.org/) is a machine learning toolkit for Kubernetes. It consists of a core set of components needed to develop, build, train, and deploy models on [Kubernetes](https://kubernetes.io/) efficiently. Cisco has been part of the Kubeflow journey since the project’s formative stage and has been one of the leading contributors with a focus on our customer needs.

## Setup
This repository needs to be cloned and the instructions in the following directories need to be followed:

- [install](./install/kfup.md) - This contains Kubernetes and Kubeflow installation instructions. These instructions should be followed to setup the base system first, before installing individual apps.

- [apps](apps/networking/ble-localization/onprem/blerssipipeline.md) - This contains apps from different verticals with each vertical being in a separate sub-folder. New apps across verticals will be regularly added. Each app has its own installation instructions that need to be followed *after* the base system has been setup. The instructions for how to use the app are also contained here.

## Getting Help
If you have questions, concerns, bug reports, etc., please create an issue against this repository. Before filing a new issue, do check if the issue has already been reported. You can also send email to the core group at *cisco-kubeflow-support AT cisco.com*.

## Getting Involved
We encourage everyone to provide us with feedback and suggest features that are high on their priority list.

## FAQ

- Am I eligible for Cisco Kubeflow Starter-pack?

The prerequisites for trying out Kubeflow Starter Pack is very simple. If you have Kubernetes v.1.14 (or lower) version installed on Cisco UCS ML servers, you are good to go. 


- What if I am a Cisco customer, but don't have Kubernetes installed?

If you are a Cisco customer, but don't have Kubernetes installed, you may consider trying Cisco Container Platform or set up Kubernetes v.1.14 on
Cisco UCS ML servers before installing Kubeflow and the starter pack. The ./install directory in this repo has instructions on how to install Kubernetes but we might not be able to provide support for Kubernetes installation. 


- What is Cisco Community Support?

Cisco's Kubeflow team is among the top contributing teams to the Kubeflow project and we contribute to some of the core Kubeflow components. The team is also actively involved in the Technical Advisory Committee of Kubeflow and the  project management of the open-source project. We have deep knowledge of internal Kubeflow architecture that allows us to address and prioritize customers bugs quickly. Cisco Kubeflow community leaders will speak on behalf of our customers and will help prioritize features that meet our customers needs.


- Does Cisco Kubeflow starter-pack support GPU?

Yes, we support Nvidia v100 GPUs.

## Credits and References
1. Cisco Blog: [ConsistentAI: Lessons from our Journey to Kubeflow 1.0](https://blogs.cisco.com/cloud/consistentai-lessons-from-our-journey-to-kubeflow-1-0)
2. [Kubeflow](https://www.kubeflow.org/)
3. [Kubernetes](https://kubernetes.io/)
