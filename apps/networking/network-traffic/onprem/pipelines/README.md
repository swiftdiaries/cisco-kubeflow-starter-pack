# Network Traffic Predicton using Kubeflow Pipelines

## What we're going to build

To train, serve, and prodict model using kubeflow pipeline through jupyter-notebook.

![TF-Network Traffic Pipeline](pictures/0-network-graph.PNG)

## Infrastructure Used

* Cisco UCS - C240


## Setup

### Install NFS server (if not installed)

To install NFS server follow steps below.

#### Retrieve Ingress IP


For installation, we need to know the external IP of the 'istio-ingressgateway' service. This can be retrieved by the following steps.

```
kubectl get service -n istio-system istio-ingressgateway
```

If your service is of LoadBalancer Type, use the 'EXTERNAL-IP' of this service.  

Or else, if your service is of NodePort Type - run the following command:  

```
kubectl get nodes -o wide
```

Use either of 'EXTERNAL-IP' or 'INTERNAL-IP' of any of the nodes based on which IP is accessible in your network.  

This IP will be referred to as INGRESS_IP from here on.

#### Installing NFS server, PVs and PVCs.

Follow the [steps](../../../ble-localization/onprem/install) to install NFS server, PVs and PVCs.



### Create Jupyter Notebook Server

Follow the [steps](../../../ble-localization/onprem/notebook#create--connect-to-jupyter-notebook-server)  to create Jupyter Notebook in Kubeflow

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
