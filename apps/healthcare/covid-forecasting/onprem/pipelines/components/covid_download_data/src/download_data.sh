#!/bin/bash -e

set -x

# Create a directory in mounted volume(s)
mkdir -p /mnt/data


while (($#)); do
   case $1 in
     "--gcs-url")
       shift
       GCS_PATH="$1"
       shift
       ;;
     "--nfs-path")
       shift
       NFS_MOUNT_PATH="$1"
       shift
       ;;
     *)
       echo "Unknown argument: '$1'"
       exit 1
       ;;
   esac
done

#Copy the contents of the GCS bucket into the mounted volume
gsutil cp -r ${GCS_PATH}* ${NFS_MOUNT_PATH}
