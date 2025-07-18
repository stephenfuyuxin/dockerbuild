# yolov5-dockerbuild
```shell
yolov5-dockerbuild# tree
.
├── aclruntime-0.0.2-cp311-cp311-linux_aarch64.whl
├── ais_bench-0.0.2-py3-none-any.whl
├── Arial.ttf
├── dockerbuild.sh
├── dockerfile
├── install_cann.sh
├── install_pta.sh
├── msit.tar
├── Python-3.11.6.tar.xz
├── requirements-yolov5.txt
├── torch-2.1.0-cp311-cp311-manylinux_2_17_aarch64.manylinux2014_aarch64.whl
├── torch_npu-2.1.0.post12-cp311-cp311-manylinux_2_17_aarch64.manylinux2014_aarch64.whl
└── yolov5.tar
```

# ais_bench（aclruntime、ais_bench）
https://gitee.com/ascend/tools/tree/master/ais-bench_workload/tool/ais_bench

# coco 数据集
模型使用 coco2017 val数据集 进行精度评估，在 yolov5 源码根目录下新建 coco 文件夹，数据集放到 coco 里。已集成到 yolov5.tar 源码包中。
```shell
coco
├── val2017
   ├── 00000000139.jpg
   ├── 00000000285.jpg
   ……
   └── 00000581781.jpg
├── instances_val2017.json
└── val2017.txt
```
其中，文件 val2017.txt 中保存 .jpg 相对路径，请自行生成该 .txt 文件，文件内容实例如下，
```shell
./val2017/00000000139.jpg
./val2017/00000000285.jpg
……
./val2017/00000581781.jpg
```

# Arial.ttf
构建工程中，下载 Arial.ttf 容易失败而导致整个构建工程异常退出，预先手动下载，放到目标路径，

下载链接：https://ultralytics.com/assets/Arial.ttf
```shell
wget -c https://ultralytics.com/assets/Arial.ttf
```
若无法下载则尝试访问 yolov5 的 github 仓库或其他官方资源获取正确的文件；

推荐预先手动下载该文件并放置到指定路径，实际执行如下，
```shell
mkdir -p ~/.config/Ultralytics/
cp /the/path/of/Arial.ttf ~/.config/Ultralytics/
```

# dockerbuild
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
-t yolov5:1 \
--target yolov5 .
```

启动构建，
```shell
# bash dockerbuild.sh
```
