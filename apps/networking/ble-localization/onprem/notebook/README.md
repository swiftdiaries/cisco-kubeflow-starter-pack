# BLERSSI Location Prediction 

## What we're going to do

Train & save a BLERSSI location model from kubeflow jupyter notebook.
Then, serve and predict using the saved model.

### Infrastructure Used

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

Follow the [steps](./../install/) to install NFS server, PVs and PVCs.

### Create & Connect to Jupyter Notebook Server

You can access Kubeflow Dashboard using the Ingress IP, provided while running [nfs-installation](./../install#-provide-ucs-cluster-ip) script, and _31380_ port. For example, http://<INGRESS_IP:31380>

Select _anonymous_ namespace and click Notebook Servers in the left panel of the Kubeflow Dashboard


![TF-BLERSSI Pipeline](pictures/1-kubeflow-ui.PNG)

Click New Server button and provide required details 

![TF-BLERSSI Pipeline](pictures/2-create-notebook.PNG)


CPU Notebook : 
	 Provide Notebook Server name and select default tensorflow-cpu-1.15  notebook image  gcr.io/kubeflow-images-public/tensorflow-1.15.2-notebook-cpu:1.0.0 from the list.

GPU Notebook
	Provide Notebook Server name and select default tensorflow-gpu-1.15 notebook image  gcr.io/kubeflow-images-public/tensorflow-1.15.2-notebook-gpu:1.0.0 from the list.

![TF-BLERSSI Pipeline](pictures/create-notebook-1.PNG)

Create new Workspace Volume as displayed in kubeflow UI.

![TF-BLERSSI Pipeline](pictures/create-notebook-2.PNG)

If you are create GPU attached notebook then choose number of GPUs and GPU Vendor.
Click LAUNCH Button

![TF-BLERSSI Pipeline](pictures/5reate-notebook-3.PNG)

Once the Notebook Server is created, click on connect button.

![TF-BLERSSI Pipeline](pictures/6-connect-notebook1.PNG)

### Upload Notebook, Data & Yaml files

Upload the [BLERSSI-Classification.ipynb](./BLERSSI-Classification.ipynb), [iBeacon_RSSI_Labeled.csv](./../data/iBeacon_RSSI_Labeled.csv) and [blerssi_kfserving.yaml](./blerssi_kfserving.yaml) to the Notebook Server.

![TF-BLERSSI Pipeline](pictures/7-upload-pipeline-notebook1.PNG)

### Train BLERSSI Model

Open the BLERSSI-Classification.ipynb file and run first command to train BLERSSI model

![TF-BLERSSI Pipeline](pictures/1-start-training.PNG)

Once training completes, the model will be stored in local notebook server

![TF-BLERSSI Pipeline](pictures/2-complete-training.PNG)

### Serve BLERSSI Model from Kubernetes PVC through Kubeflow Kfserving

![TF-BLERSSI Pipeline](pictures/4-create-kfserving-blerssi.PNG)

### Predict location for test data using served BLERSSI Model 

Change Ingress IP in the curl command to your provided value before executing location prediction.


![TF-BLERSSI Pipeline](pictures/5-predict-model.PNG)

Prediction - class_ids(38) in response is location and predicted using kubeflow-kfserving which represents the location "M05"

