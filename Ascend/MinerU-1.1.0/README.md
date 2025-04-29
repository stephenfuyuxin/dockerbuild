# MinerU-1.1.0 构建工程使用指导
以 `dockerbuild/Ascend/Template/README.md` 作为镜像工程使用标准参考，准备工作目录及启动工程构建脚本，

[dockerbuild/Ascend/Template/README.md](https://github.com/stephenfuyuxin/dockerbuild/blob/main/Ascend/Template/README.md)

模型 `MinerU-1.1.0` 相关操作参考 `npuAdapter/MinerU-1.1.0/README.md` ，

[npuAdapter/MinerU-1.1.0/README.md](https://github.com/stephenfuyuxin/npuAdapter/blob/main/MinerU-1.1.0/README.md)

# 预先准备
**表1** MinerU-1.1.0 预先准备
  | 项目                    | 版本         | 来源说明                                                                                                                                                  |
  | ----------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | mineru-modelscope.tar   | NA          | 参考`npuAdapter/MinerU-1.1.0/README.md` 压缩/解压缩                                                                                                         |
  | paddleocr.tar           | NA          | 参考`npuAdapter/MinerU-1.1.0/README.md` 压缩/解压缩                                                                                                         |
  | unitable_*.pth          | NA          | https://www.modelscope.cn/models/RapidAI/RapidTable/files                                                                                                 |
  | python                  | 3.10.14     | https://mirrors.huaweicloud.com/python/3.10.14/Python-3.10.14.tar.xz                                                                                      |
  | torch                   | 2.1.0       | pip install torch==2.1.0                                                                                                                                  |
  | torch_npu               | 2.1.0.post8 | https://gitee.com/ascend/pytorch/releases/download/v6.0.0-pytorch2.1.0/torch_npu-2.1.0.post8-cp310-cp310-manylinux_2_17_aarch64.manylinux2014_aarch64.whl |
  | torchvision             | 0.16.0      | pip install torchvision==0.16.0                                                                                                                           |
  | trochvision_npu         | 0.16.0+xxx  | 需手动编译，https://gitee.com/ascend/vision                                                                                                                |
  | msit                    | NA          | git之后通过tar压缩使用，https://gitee.com/ascend/msit                                                                                                       |
  | detectron2              | NA          | git之后通过tar压缩使用，https://github.com/facebookresearch/detectron2                                                                                      | 
  | magic-pdf               | 1.1.0       | https://github.com/opendatalab/MinerU/releases                                                                                                            |

注，构建工程所需模型侧相关文件变更及替换，请参考 `npuAdapter/MinerU-1.1.0/` 预先准备。

# 不同用户使用不同的 dockerfile-xxxx
针对镜像启动所使用的用户，以 root 和 非root 用户分类，
- 如果是 root 用户，使用 `dockerfile-root`，
```sh
mv dockerfile-root dockerfile
```
- 如果是 非root 用户，使用 `dockerfile-mineru`，
```sh
mv dockerfile-mineru dockerfile
```

# 工程构建
准备好工作目录，并放置所有所需文件，并在工作目录启动 `dockerbuild.sh` 工程化构建。
```sh
bash dockerbuild.sh
```
