# BLERSSI Location Prediction using Kubeflow Fairing 

## What we're going to build

Train & Save a BLERSSI location model using Kubeflow fairing from jupyter notebook. Then, deploy the trained model to Kubeflow for Predictions.


## Infrastructure Used

* Cisco UCS - C240


## Setup


### Install NFS server (if not installed)

To install NFS server follow [steps](./../notebook#install-nfs-server-if-not-installed)

### Create Jupyter Notebook Server

Follow the [steps](./../notebook#create--connect-to-jupyter-notebook-server) to create & connect to Jupyter Notebook Server in Kubeflow

### Upload Notebook, Dockerfile and blerssi-model files

Upload [BLERSSI-Classification-fairing.ipynb](BLERSSI-Classification-fairing.ipynb), [Dockerfile](Dockerfile) and [blerssi-model.py](blerssi-model.py) to notebook server.

![TF-BLERSSI Upload](pictures/15_Upload_files.PNG)

### Run BLERSSI Notebook

Open the BLERSSI-Classification-fairing.ipynb file and run notebook

### Configure Docker credentials

![TF-BLERSSI Docker Configure](pictures/1_configure_docker_credentials.PNG)

### Create requirements.txt with require python packages

![TF-BLERSSI Create requirements](pictures/2_create_requirements_file.PNG)

### Import Fairing Packages

![TF-BLERSSI Import Libraries](pictures/3_import_python_libraries.PNG)

![TF-BLERSSI Setup Fairing](pictures/4_setup_kf_fairing.PNG)

### Get minio-service cluster IP to upload docker build context

Note: Please change DOCKER_REGISTRY to the registry for which you've configured credentials. Built training image are pushed to this registry.

![TF-BLERSSI Minio Service](pictures/5_minio_service_ip.PNG)

### Create config-map to map your own docker credentials from created config.json

Note: create configmap named "docker-config". If already exists, delete existing one and create new configmap.

* Delete existing configmap

```
kubectl delete configmap -n $namespace docker-config
```

![TF-BLERSSI Create Configmap](pictures/6_create_configmap.PNG)

### Build docker image for our model

output_map is a map from source location to the location inside the context.

![TF-BLERSSI Build Docker Image](pictures/7_build_docker_image.PNG)

### Define TFJob Class to create training job

![TF-BLERSSI Define TFJob](pictures/8_define_TFJob.PNG)

### Define Blerssi class to be used by Kubeflow fairing

Note: Must necessarily contain train() and predict() methods


![TF-BLERSSI Serve](pictures/9_define_blerssi_serve.PNG)


### Train Blerssi model remotely on Kubeflow

Kubeflow Fairing packages the BlerssiServe class, the training data, and prerequisites as a Docker image. 
It the builds & runs the training job on kubeflow.

![TF-BLERSSI Training](pictures/10_training_using_fairing.PNG)

### Deploy the trained model to Kubeflow for predictions

![TF-BLERSSI Deploy model](pictures/11_deploy_trained_model_for_prediction.PNG)


### Get prediction endpoint

![TF-BLERSSI Predicion Endpoint](pictures/12_get_prediction_endpoint.PNG)

### Predict location for data using prediction endpoint

Change endpoint in the curl command to previous cell output, before executing location prediction.

![TF-BLERSSI prediction](pictures/13_prediction.PNG)

### Clean up the prediction endpoint
Delete the prediction endpoint created by this notebook.

![TF-BLERSSI Delete endpoine](pictures/14_delete_prediction_endpoint.PNG)
