# Network Traffic location classifier using Kubeflow Pipelines

## What we're going to build

To train, serve, and prodict model using kubeflow pipeline through jupyter-notebook.

![TF-Network Traffic Pipeline](pictures/0-network-graph.PNG)

## Infrastructure Used

Google Kubernetes Engine (Cloud)


## Setup

### Kubeflow Installation

Follow the [steps](./../../kubeflow-v1.0-installation) to install kubeflow v1.0 in GKE.


### Create secrets for github token

```
kubectl create secret generic git --from-literal=GITHUB_TOKEN=<enter your token> -n kubeflow
```

### Create Jupyter Notebook Server

Follow the [steps](./../notebook)  to create Jupyter Notebook in Kubeflow

### Upload Notebook file

Upload Network Traffic-Pipeline-Deployment.ipynb file from [here](./Network-Pipeline-Deployment.ipynb)

### Run Network Traffic Pipeline

Open the Network Traffic-Pipeline-Deployment.ipynb file and run pipeline

Clone git repo

![TF-Network Traffic  Pipeline](pictures/1-git-clone.PNG)

Loading Components

![TF-BLERSSI Pipeline](pictures/2-load-compoents.PNG)

Run Pipeline

![TF-Network Traffic Pipeline](pictures/2-run-pipeline.PNG)

Once Network Traffic Pipeline is executed Experiment and Run link will generate and displayed as output

![TF-Network Traffic Pipeline](pictures/3-exp-link.PNG)

Click on latest experiment which is created

![TF-Network Traffic Pipeline](pictures/4-pipeline-created.PNG)

Pipeline components execution can be viewed as below

![TF-Network Traffic Pipeline](pictures/6-pipeline-completed.PNG)


Logs of Network Traffic Training Component

![TF-Network Traffic Pipeline](pictures/2-training.PNG)

Logs of Serving Component

![TF-Network Traffic Pipeline](pictures/3-serving.PNG)

Logs of WebUI Component

![TF-Network Traffic Pipeline](pictures/4-webui.PNG)

Tensorboard Graph for Network Traffic

![TF-Network Traffic Pipeline](pictures/5-tensorboard-graph.PNG)

Predict Network Traffic Location using Web UI - upload data file located at [location](./../data/Network_Traffic.csv)

![TF-Network Traffic Pipeline](pictures/7-upload-file-1.PNG)

Network Traffic Prediction Location with Probability

![TF-Network Traffic Pipeline](pictures/8-show-table.PNG)
