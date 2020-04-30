# COVID-19 Forecasting using Kubeflow Pipelines

## What we're going to build

To train, serve and prodict  model  using kubeflow pipeline through jupyter-notebook.

![COVID Pipeline](./pictures/0-covid-pipeline.PNG)

## Infrastructure Used

* Cisco UCS - C240M5 

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

Follow the [steps](https://github.com/CiscoAI/cisco-kubeflow-starter-pack/tree/dev/apps/networking/ble-localization/onprem/install) to install NFS server, PVs and PVCs.

### Create Jupyter Notebook Server

Follow the [steps](https://github.com/CiscoAI/cisco-kubeflow-starter-pack/tree/master/apps/networking/ble-localization/onprem/notebook#create--connect-to-jupyter-notebook-server) to create & connect to Jupyter Notebook Server in Kubeflow

### Upload Notebook file

Upload [COVID-Pipeline-Deployment.ipynb](COVID_Pipeline_Deployment.ipynb)

### Run BLERSSI Pipeline

Open the COVID-Pipeline-Deployment.ipynb file and run pipeline

Clone git repo

![COVID Pipeline](./pictures/1-clone-repo.PNG)

Loading Components

![COVID Pipeline](./pictures/2-load-components.PNG)


Defining the COVID Pipeline Function

![COVID Pipeline](./pictures/3-def-pipline-fn.PNG)


Once COVID Pipeline is executed, Experiment and Run link will be generated and displayed as output

![COVID Pipeline](pictures/4-run-pipeline.PNG)


Click on latest experiment which is created 

![TF-COVID Pipeline](./pictures/5-latest-experimnt.png)


Pipeline components execution can be viewed as below.

Logs of COVID Preprocessing Component

![TF-COVID Pipeline](./pictures/6-covid-preprocess.PNG)


Logs of COVID Training Component

![TF-COVID Pipeline](./pictures/7-covid-train.PNG)


Logs of COVID TF Serving Component

![TF-COVID Pipeline](./pictures/8-covid-serving.PNG)


Predict Results of COVID Model Serving by sending a curl request to the covid-serve service that is running.

![TF-COVID Pipeline](./pictures/9-pred-results.PNG)


