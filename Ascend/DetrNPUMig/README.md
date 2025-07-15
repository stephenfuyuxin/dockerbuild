# detr-dockerbuild
```shell
detr-dockerbuild# tree
.
├── aclruntime-0.0.2-cp311-cp311-linux_aarch64.whl
├── ais_bench-0.0.2-py3-none-any.whl
├── Ascend-cann-kernels-910b_8.1.RC1_linux-aarch64.run
├── Ascend-cann-toolkit_8.1.RC1_linux-aarch64.run
├── coco_data.tar
├── dockerbuild.sh
├── dockerfile
├── install_cann.sh
├── install_pta.sh
├── modelzoo-pytorch-detr.tar
├── Python-3.11.6.tar.xz
├── requirements-detr.txt
├── resnet50-0676ba61.pth
├── torch-2.1.0-cp311-cp311-manylinux_2_17_aarch64.manylinux2014_aarch64.whl
└── torch_npu-2.1.0.post12-cp311-cp311-manylinux_2_17_aarch64.manylinux2014_aarch64.whl
```

# dockerbuild.sh
```shell
# vim dockerbuild.sh
#!/bin/bash

docker build \
--build-arg no_proxy=127.0.0.1,localhost,local,.local,172.17.0.1 \
--build-arg DEVICE=910b \
--build-arg ARCH=aarch64 \
--build-arg CANN_VERSION=8.1.RC1 \
--build-arg PYTHON_VERSION=3.11.6 \
--build-arg PY_VERSION=311 \
--build-arg TORCH_VERSION=2.1.0 \
-t detr:1 \
--target detr .
```
启动构建，
```shell
# bash dockerbuild.sh
```
