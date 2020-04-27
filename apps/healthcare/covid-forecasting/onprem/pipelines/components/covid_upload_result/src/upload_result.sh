#!/bin/bash -e

set -x

while (($#)); do
   case $1 in
     "--gcs-url")
       shift
       GCS_PATH="$1"
       shift
       ;;
     *)
       echo "Unknown argument: '$1'"
       exit 1
       ;;
   esac
done
gsutil mb ${GCS_PATH}
gsutil cp -r /mnt/train_df.csv ${GCS_PATH}  
gsutil cp -r /mnt/predict_df.csv ${GCS_PATH}  
