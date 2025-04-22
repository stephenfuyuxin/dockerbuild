# 镜像构建指导

- [获取基础镜像](#获取基础镜像)
- [检查基础镜像](#检查基础镜像)
- [工程化构建方案](#工程化构建方案)
  - [昇腾容器方案体系结构](#昇腾容器方案体系结构)
  - [多阶段构建说明](#多阶段构建说明)
    - [Dockerfile](#Dockerfile)
    - [Dockerbuild](#Dockerbuild)
- [工作目录](#工作目录)
  - [准备软件包](#准备软件包)
  - [启用 http.server](#启用-http.server)
- [镜像构建说明](#镜像构建说明)
  - [使用 wget 获取构建所需文件](#使用-wget-获取构建所需文件)
  - [开始构建](#开始构建)

# 获取基础镜像
通过dockerhub或其他镜像站获取，以 `dockerhub` 为例，执行
```sh
docker pull ubuntu:22.04
```
注：若无额外说明，默认 `base` 镜像均为 `ubuntu:22.04`。

# 检查基础镜像
通过以下命令检查 `base` 镜像是否正常拉取到本地，执行
```sh
docker images | grep ubuntu
```
回显结果中包含 `ubuntu:22.04` 即可。

# 工程化构建方案
在 `base` 镜像基础上，通过 `Dockerfile` 多阶段逐层构建获取最终目的镜像的方案。

## 昇腾容器方案体系结构
参考 hiascend 官方链接：[hiascend.com](https://www.hiascend.com/)

文档通常随版本更新，通用的文档路径：文档->CANN软件安装->安装说明->安装方案；

## 多阶段构建说明
多阶段构建允许通过多个 `FROM` 指令在 `Dockerfile` 中定义多个构建阶段，并最终选择其中一个阶段作为最终镜像。

多阶段构建核心思想：多阶段构建遵循“逐层构建”原则，上一个阶段构建的输出作为下一个阶段构建的输入。

举例说明，假设一个包含 ABC 3-阶段 `Dockerfile` 文件，可以构建到C阶段作为最终镜像，也可以忽略C阶段仅构建到B阶段作为最终镜像。

注：如果要构建到C阶段作为最终结项，且忽略B阶段，则需要修改 `Dockerfile` 文件，删除或注释B阶段代码。

### Dockerfile
```dockerfile
# 第一阶段，以 ubuntu:22.04 作为基础镜像，构建阶段 A_stage
FROM ubuntu:22.04 AS A_stage

# 第二阶段，以 A_stage 作为基础镜像，构建阶段 B_stage
FROM A_stage AS B_stage

# 第三阶段，以 B_stage 作为基础镜像，构建阶段 C_stage
FROM B_stage AS C_stage
```

### Dockerbuild
```sh
# 完整构建，构建到 C_stage 阶段；
docker build --target C_stage -t <image-name>:<image-tag> .

# 部分构建，构建到 B_stage 阶段，C_stage 阶段代码并未执行；
docker build --target B_stage -t <image-name>:<image-tag> .
```

# 工作目录
工作目录用于放置镜像工程化构建所需的文件，以及作为 `http.server` 的 `home-page` 在构建过程中通过 `wget` 提供所需文件。

## 准备软件包
工作目录所包含的软件包大致如下，以下可能只是所需的最小集，根据不同模型不同训练/推理等使用场景一定存在差异，以实际情况为准。
```
the/path/of/workingdir
├── dockerfile
├── dockerbuild.sh
├── Ascend-cann-toolkit*
├── Ascend-cann-kernels*
├── Ascend-cann-nnal* （自研 MindIE 推理框架算子包）
├── torch*
├── torch_npu* （torch 在 npu 上的适配，根据业务类型，可能还需要 torchvision_npu 等）
├── Ascend-mindie* （自研 MindIE 推理框架）
├── Ascend-mindie-atb-models* （自研 MindIE 推理加框代码仓）
├── install_cann.sh
├── install_pta.sh
├── install_mindie.sh （自研 MindIE 推理框架安装脚本）
├── requirements*.txt （模型所需 pip 依赖清单，根据实际情况也可能包含多个）
├── README.md
```

## 启用 http.server
使用 `Python` 原生 `http.server` 服务。

前提：执行工程化构建的宿主机/云节点上需要预先安装有可用的`Python3.x`。

在 `the/path/of/workingdir` 目录，执行以下 `python` 代码，
```python
# python 原生自带 http server，数字表示所用端口，可根据实际情况更换；
python3 -m http.server <port>
```
这里，默认使用 `3000` 作为 `http.server` 启用端口，
```python
python3 -m http.server 3000
```

# 镜像构建说明

## 使用 wget 获取构建所需文件
在 `dockerfile` 中 `wget` 获取构建所需文件，`wget` 命令配合 `docker0` 及 `http.server` 所用端口进行文件传输，提供镜像工程化构建所需文件。
```sh
wget -q http://172.17.0.1:<port>/xxx -P /WORKDIR
```
若 `http.server` 默认使用 3000 作为 `http.server` 启用端口，则
```sh
wget -q http://172.17.0.1:3000/xxx -P /WORKDIR
```
注，这里 `WORKDIR` 为 `dockerfile` 文件中指定镜像构建工作目录，与 [准备软件包](#准备软件包) 中 `workingdir` 并非同一概念。

## 开始构建
通过 `dockerbuild.sh` 脚本执行，启动镜像工程化构建，构建脚本包含传参清单、多阶段构建、镜像信息等。
```sh
bash dockerbuild.sh
```
