# COVID-19 Forecasting using Kubeflow Fairing 

## What we're going to build

Train & Save a COVID model using Kubeflow Fairing from Jupyter Notebook. Then, deploy the trained model to Kubeflow for Predictions.


## Infrastructure Used

* Cisco UCS - C240


## Setup


### Install NFS server (if not installed)

To install NFS server follow [steps](./../notebook#install-nfs-server-if-not-installed)

### Create Jupyter Notebook Server

Follow the [steps](./../notebook#create--connect-to-jupyter-notebook-server) to create & connect to Jupyter Notebook Server in Kubeflow

### Upload Notebook, Input Data files

Upload [COVID-Forecast-fairing.ipynb](COVID-Forecast-fairing.ipynb), [train.csv](../data/train.csv) & [test.csv](../data/test.csv) to notebook server.

![COVID Upload](pictures/0_upload_files.png)

### Run COVID Notebook

Open the COVID-Forecast-fairing.ipynb file and run notebook. Requirements.txt and docker configuration file (config.json) will be added automatically.

### Configure Docker Registry credentials 

![COVID Configure](pictures/1_configure_docker_credentials.png)

### Create requirements.txt with require python packages

![COVID Create requirements](pictures/2_create_requirements_file.png)

### Import Required Libraries

![COVID Import Libraries](pictures/3_import_python_libraries.png)

![COVID Setup Fairing](pictures/4_setup_kf_fairing.png)

### Get minio-service cluster IP to upload docker build context

Note: Please change DOCKER_REGISTRY to the registry for which you've configured credentials. Minio is used as the build context source here.

![COVID Minio Service](pictures/5_minio_service_ip.png)

### Create config-map to map your own docker credentials from created config.json

Note: create configmap named "docker-config". If already exists, delete existing one and create new configmap.

* Delete existing configmap

```
kubectl delete configmap -n $namespace docker-config
```

![COVID Create Configmap](pictures/6_create_configmap.png)

### Add Preprocessing Function for train data

![COVID Preprocess Train](pictures/7_preprocess_train.png)

### Add Preprocessing Function for test data

![COVID Preprocess Test](pictures/8_preprocess_test.png)


### Add Central Preprocessing Function

![COVID Preprocess Central](pictures/9_preprocess_central.png)


### Add Function for Training Model

![COVID Model Train](pictures/10_train_model_function.png)


### Define COVID class to be used by Kubeflow fairing

Note: Must necessarily contain train() and predict() methods


![COVID Serve](pictures/11_define_covid_serve.png)


### Train COVID model on Kubeflow

Kubeflow Fairing packages the CovidServe class, the training data, and requirements.txt as a Docker image. 
It then builds & runs the training job on Kubeflow.

![COVID Training](pictures/12_training_using_fairing.png)

### Deploy the trained model to Kubeflow for predictions

![COVID Deploy model](pictures/13_deploy_trained_model_for_prediction.png)


### Get prediction endpoint

![COVID Predicion Endpoint](pictures/14_get_prediction_endpoint.png)

### Predict location for data using prediction endpoint

![COVID prediction](pictures/15_prediction.png)

### Perform Post Processing of Prediction Result

![COVID prediction](pictures/16_postprocessing.png)

### Visualise the Final Prediction Results

![COVID prediction](pictures/17_visualising.png)

### View Visualised Results as Graph

![COVID prediction](pictures/18_view_graph.png)

