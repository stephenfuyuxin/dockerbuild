#!/bin/bash

docker build \
--build-arg no_proxy=127.0.0.1,localhost,local,.local,172.17.0.1 \
--build-arg DEVICE=910b \
--build-arg ARCH=aarch64 \
--build-arg CANN_VERSION=8.1.RC1 \
--build-arg PYTHON_VERSION=3.11.6 \
--build-arg PY_VERSION=311 \
--build-arg TORCH_VERSION=2.1.0 \
-t yolov5:1 \
--target yolov5 .
