#!/bin/bash -e

# Copyright 2018 The Kubeflow Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -x

KUBERNETES_NAMESPACE="${KUBERNETES_NAMESPACE:-kubeflow}"
SERVER_NAME="${SERVER_NAME:-covid-model}"

while (($#)); do
   case $1 in
     "--namespace")
       shift
       KUBERNETES_NAMESPACE="$1"
       shift
       ;;
     "--timestamp")
       shift
       TIMESTAMP="$1"
       shift
       ;;
     "--server-name")
       shift
       SERVER_NAME="$1"
       shift
       ;;       
     *)
       echo "Unknown argument: '$1'"
       exit 1
       ;;
   esac
done

if [ -z "${TIMESTAMP}" ]; then
  echo "Timestamp needs to be added"
  exit 1
fi

CLUSTER_NAME="covid-pipeline"

# Connect kubectl to the local cluster
kubectl config set-cluster "${CLUSTER_NAME}" --server=https://kubernetes.default --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
kubectl config set-credentials pipeline --token "$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"
kubectl config set-context kubeflow --cluster "${CLUSTER_NAME}" --user pipeline
kubectl config use-context kubeflow
kubectl get secret git -n kubeflow -o yaml | grep GIT | cut -d : -f 2 |sed 's/ //g'|base64 --decode > /tmp/git.txt
readtoken=$(cat /tmp/git.txt)

# Configure before TF serving implementation
cd /src/github.com/kubeflow/kubeflow
git checkout ${KUBEFLOW_VERSION}
export GITHUB_TOKEN=$readtoken
cd /opt

#Make folder to store yaml files for kustomization
mkdir covid_serve
cd covid_serve/
touch kustomization.yaml covid_serve.yaml covid_service.yaml

#Write configuration code into yaml files
cat >> kustomization.yaml << EOF
resources:
- covid_serve.yaml
- covid_service.yaml

namePrefix: serve-
EOF

cat >> covid_serve.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: covid
  name: covid-v1
  namespace: kubeflow
spec:
  selector:
    matchLabels:
      app: covid
  template:
    metadata:
      annotations:
        sidecar.istio.io/inject: "true"
      labels:
        app: covid
        version: v1
    spec:
      containers:
      - args:
        - --port=9000
        - --rest_api_port=8500
        - --model_base_path=/mnt/Model_Covid/Model_Covid
        env:
        - name: MODEL_NAME
          value: "Model_Covid"
        image: tensorflow/serving
        name: tensorflow-serving
        imagePullPolicy: IfNotPresent
        volumeMounts:
        - mountPath: "/mnt/Model_Covid/"
          name: "nfsvolume"
      volumes:
       - name: "nfsvolume"
         persistentVolumeClaim:
           claimName: "nfs"
EOF

cat >> covid_service.yaml << EOF
apiVersion: v1
kind: Service
metadata:
  labels:
    app: covid
  name: covid-service
  namespace: kubeflow
spec:
  ports:
  - name: grpc-tf-serving
    port: 9000
    targetPort: 9000
  - name: http-tf-serving
    port: 8500
    targetPort: 8500
  selector:
    app: covid
  type: NodePort
EOF

echo "Installing kustomize"
wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.5.4/kustomize_v3.5.4_linux_amd64.tar.gz
tar -xvf kustomize_v3.5.4_linux_amd64.tar.gz
export PATH=$PATH:$PWD

#Build a service and a deployment using kustomize for COVID serving
kustomize build . | kubectl apply -f -

# Wait for the deployment to have at least one available replica
echo "Waiting for the TF Serving deployment to show up..."
timeout="60"
start_time=`date +%s`
while [[ $(kubectl get deploy --namespace "${KUBERNETES_NAMESPACE}" --selector=app="${SERVER_NAME}" 2>&1|wc -l) != "2" ]];do
  current_time=`date +%s`
  elapsed_time=$(expr $current_time + 1 - $start_time)
  if [[ $elapsed_time -gt $timeout ]];then
    echo "TF serving deployment timeout"
    exit 1
  fi
  sleep 2
done

echo "Waiting for the valid workflow json..."
start_time=`date +%s`
exit_code="1"
while [[ $exit_code != "0" ]];do
  kubectl get deploy --namespace "${KUBERNETES_NAMESPACE}" --selector=app="${SERVER_NAME}" --output=jsonpath='{.items[0].status.availableReplicas}'
  exit_code=$?
  current_time=`date +%s`
  elapsed_time=$(expr $current_time + 1 - $start_time)
  if [[ $elapsed_time -gt $timeout ]];then
    echo "Valid workflow json timeout"
    exit 1
  fi
  sleep 2
done


echo "Obtaining the pod name..."
start_time=`date +%s`
pod_name=""
while [[ $pod_name == "" ]];do
  pod_name=$(kubectl get pods --namespace "${KUBERNETES_NAMESPACE}" --selector=app="${SERVER_NAME}" --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
  current_time=`date +%s`
  elapsed_time=$(expr $current_time + 1 - $start_time)
  if [[ $elapsed_time -gt $timeout ]];then
    echo "Pod name reception timeout"
    exit 1
  fi
  sleep 2
done
echo "Pod name is: " $pod_name

# Wait for the pod container to start running
echo "Waiting for the TF Serving pod to start running..."
start_time=`date +%s`
exit_code="1"
while [[ $exit_code != "0" ]];do
  kubectl get po ${pod_name} --namespace "${KUBERNETES_NAMESPACE}" -o jsonpath='{.status.containerStatuses[0].state.running}'
  exit_code=$?
  current_time=`date +%s`
  elapsed_time=$(expr $current_time + 1 - $start_time)
  if [[ $elapsed_time -gt $timeout ]];then
    echo "TF serving pod running status timeout"
    exit 1
  fi
  sleep 2
done

start_time=`date +%s`
while [ -z "$(kubectl get po ${pod_name} --namespace "${KUBERNETES_NAMESPACE}" -o jsonpath='{.status.containerStatuses[0].state.running}')" ]; do
  current_time=`date +%s`
  elapsed_time=$(expr $current_time + 1 - $start_time)
  if [[ $elapsed_time -gt $timeout ]];then
    echo "timeout"
    exit 1
  fi
  sleep 5
done
