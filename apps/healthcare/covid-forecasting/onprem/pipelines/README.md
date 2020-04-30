# COVID-19 Forecasting using Kubeflow Pipelines

## What we're going to build

To train, serve a COVID model using Kubeflow Pipeline and get forecast for a client request through Jupyter notebook.

![COVID Pipeline](./pictures/0-covid-pipeline.PNG)

## Infrastructure Used

* Cisco UCS - C240M5 and C480ML 

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

Follow the [steps](./../../../../networking/ble-localization/onprem/install) to install NFS server, PVs and PVCs.

### Create Jupyter Notebook Server

Follow the [steps](https://github.com/CiscoAI/cisco-kubeflow-starter-pack/tree/master/apps/networking/ble-localization/onprem/notebook#create--connect-to-jupyter-notebook-server) to create & connect to Jupyter Notebook Server in Kubeflow

### Upload Notebook file

Upload [COVID-Pipeline-Deployment.ipynb](COVID_Pipeline_Deployment.ipynb)

### Run BLERSSI Pipeline

Open the COVID-Pipeline-Deployment.ipynb file and run pipeline

Clone git repo

![COVID Pipeline](./pictures/1-clone-repo.PNG)

Load The Components

![COVID Pipeline](./pictures/2-load-components.PNG)


Define the COVID Pipeline Function

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

![TF-COVID Pipeline](./pictures/8-covid-serve.PNG)

Send a curl request to covid model service endpoint and get prediction/forecast results.

```
curl -v http://10.100.228.205:8500/v1/models/Model_Covid:predict -d '{"signature_name":"serving_default","instances":[{"input1":[[1.0986122886681098, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.6931471805599453],[0.0, 0.0],[1.0986122886681098, 0.0],[0.6931471805599453, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0]], "input2":[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0]}, {"input1":[[1.0986122886681098, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.6931471805599453],[0.0, 0.0],[1.0986122886681098, 0.0],[0.6931471805599453, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0],[0.0, 0.0]], "input2":[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0]} ]}'

```
Output:

```
*   Trying 10.99.104.192...
* TCP_NODELAY set
* Connected to 10.99.104.192 (10.99.104.192) port 8500 (#0)
> POST /v1/models/Model_Covid:predict HTTP/1.1
> Host: 10.99.104.192:8500
> User-Agent: curl/7.63.0
> Accept: */*
> Content-Length: 3908
> Content-Type: application/x-www-form-urlencoded
> Expect: 100-continue
>
< HTTP/1.1 100 Continue
* We are completely uploaded and fine
< HTTP/1.1 200 OK
< Content-Type: application/json
< Date: Thu, 30 Apr 2020 13:37:01 GMT
< Content-Length: 1516
<
{
    "predictions": [[3.71306396e-06, 6.48195453e-07, 3.59812134e-06, 1.01000251e-06, 6.99493876e-06, 1.83913096e-06, 4.58340446e-06, 9.02905526e-07, 9.59076442e-06, 1.22532163e-06, 7.27896304e-06, 1.20176969e-06, 5.31440946e-06, 1.50903679e-06, 2.09175e-06, 7.40330222e-07, 1.14892537e-05, 1.35839412e-06, 1.05419758e-05, 5.92884078e-07, 1.05328818e-05, 1.12036582e-06, 2.78480093e-05, 1.24785288e-06, 2.02848933e-05, 6.77313153e-07, 2.69135126e-05, 1.8475198e-06, 3.51139279e-05, 1.95976213e-06, 2.96442777e-05, 5.46645367e-07, 8.02301511e-05, 1.52324856e-06, 0.000855864957, 8.5055035e-07, 0.085144192, 9.31548186e-07, 0.0946462601, 1.05992603e-06, 0.138091743, 1.53388135e-06, 0.191763729, 1.13644512e-06, 0.177047938, 1.91902927e-06, 0.312126338, 8.4027e-07], [3.71306396e-06, 6.48195453e-07, 3.59812134e-06, 1.01000251e-06, 6.99493876e-06, 1.83913096e-06, 4.58340446e-06, 9.02905526e-07, 9.59076442e-06, 1.22532163e-06, 7.27896304e-06, 1.20176969e-06, 5.31440946e-06, 1.50903679e-06, 2.09175e-06, 7.40330222e-07, 1.14892537e-05, 1.35839412e-06, 1.05419758e-05, 5.92884078e-07, 1.05328818e-05, 1.12036582e-06, 2.78480093e-05, 1.24785288e-06, 2.02848933e-05, 6.77313153e-07, 2.69135126e-05, 1.8475198e-06, 3.51139279e-05, 1.95976213e-06, 2.96442777e-05, 5.46645367e-07, 8.02301511e-05, 1.52324856e-06, 0.000855864957, 8.5055035e-07, 0.085144192, 9.31548186e-07, 0.0946462601, 1.05992603e-06, 0.138091743, 1.53388135e-06, 0.191763729, 1.13644512e-06, 0.177047938, 1.91902927e-06, 0.312126338, 8.4027e-07]
    ]
* Connection #0 to host 10.99.104.192 left intact
```

![TF-COVID Pipeline](./pictures/9-pred-results.PNG)


