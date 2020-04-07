#!/bin/bash

export KFX_VERSION=v0.1.0-alpha
export OPSYS=linux
curl hhttp://storage.googleapis.com/kfx-releases/${KFX_VERSION}/${OPSYS}/kfx > kfx && chmod +x kfx
./kfx install kf
