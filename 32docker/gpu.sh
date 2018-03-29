安装docker

安装nvidia-docker

创建容器：
    sudo docker run --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=0 --name deep-image -v /home/xlji/work/luozong/deep-image-prior-ok/docker:/opt/data -i -t ubuntu:14.04 /bin/bash
    参数：
        --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all
