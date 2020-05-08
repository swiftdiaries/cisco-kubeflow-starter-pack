# COVID-19 Forecasting using Kubeflow Fairing 

## What we're going to build

Train & Save a COVID forecast model using Kubeflow Fairing from Jupyter Notebook. Then, deploy the trained model to Kubeflow using Kubeflow Fairing for Predictions.


## Infrastructure used

* Cisco UCS - C240


## Setup


### Install NFS server (if not installed)

To install NFS server follow [steps](./../notebook#install-nfs-server-if-not-installed)

### Create Jupyter notebook server

Follow the [steps](./../notebook#create--connect-to-jupyter-notebook-server) to create & connect to Jupyter Notebook Server in Kubeflow.

### Upload COVID Forecast Fairing notebook

Upload the [COVID-Forecast-fairing notebook](./COVID-Forecast-fairing.ipynb) into Jupyter Notebook server in Kubeflow.

![COVID upload](pictures/0_upload_notebook.png)


### Run COVID notebook

Open & run the uploaded COVID-Forecast-fairing.ipynb file.


### Clone Cisco Kubeflow starter pack repository

![COVID Clone](pictures/1_clone_repo.png)


### Configure Docker Registry credentials 

![COVID Configure](pictures/2_configure_docker_credentials.png)

### Create requirements.txt with required python packages

![COVID Create requirements](pictures/3_create_requirements_file.png)

### Import required libraries

![COVID Import Libraries](pictures/4_import_python_libraries.png)

![COVID Setup Fairing](pictures/5_setup_kf_fairing.png)

### Get minio-service cluster IP to upload Docker build context

Note: Please change DOCKER_REGISTRY to the registry for which you've configured credentials. Minio is used as the build context source here.

![COVID Minio Service](pictures/6_minio_service_ip.png)

### Create config-map to map your own docker credentials from created config.json

Note: create configmap named "docker-config". If already exists, delete existing one and create new configmap.

* Delete existing configmap

```
kubectl delete configmap -n $namespace docker-config
```

![COVID Create Configmap](pictures/7_create_configmap.png)

### Define paths for train & test data files

![COVID Define paths](pictures/8_define_paths.png)

### Add pre-processing function for train data

![COVID Preprocess Train](pictures/9_preprocess_train.png)

### Add pre-processing function for test data

![COVID Preprocess Test](pictures/10_preprocess_test.png)


### Add main pre-processing function

![COVID Preprocess Central](pictures/11_preprocess_central.png)


### Add function for training Model

![COVID Model Train](pictures/12_train_model_function.png)


### Define COVID class to be used by Kubeflow Fairing

Note: Must necessarily contain train() and predict() methods


![COVID Serve](pictures/13_define_covid_serve.png)


### Train COVID model using Kubeflow Fairing

Kubeflow Fairing packages the CovidServe class, the training data, and requirements.txt as a Docker image. 
It then builds & runs the training job on Kubeflow.

![COVID Training](pictures/14_training_using_fairing.png)

### Deploy trained model to Kubeflow for predictions using Kubeflow Fairing

![COVID Deploy model](pictures/15_deploy_trained_model_for_prediction.png)


### Get prediction endpoint

![COVID Predicion Endpoint](pictures/16_get_prediction_endpoint.png)

### Predict for input data using prediction endpoint

![COVID prediction](pictures/17_prediction.png)

### Perform post-processing of prediction result

![COVID postprocessing](pictures/18_postprocessing.png)

### Visualise the final prediction results

![COVID visualise](pictures/19_visualising.png)

### View visualised results as graph

![COVID view graph](pictures/20_view_graph.png)

### Delete prediction endpoint

![COVID Delete endpoint](pictures/21_delete_endpoint.png)



