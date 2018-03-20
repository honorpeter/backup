开启docker守护进程：
        sudo start docker
        sudo service docker start

        sudo stop docker
        sudo service docker stop
查看运行情况： 
        sudo docker info

Building our first container:
        sudo docker run -i -t ubuntu /bin/bash
            The -i flag keeps STDIN open from the container
            The -t flag is the other half and tells Docker to assign a 
                    pseudo-tty to the container we're about to create

        sudo docker run --name deep-image -v $PWD/data1:/opt/data -i -t ubuntu /bin/bash
          --name:设置名字    -v设置共享文件  -it交互式环境 ubuntu:latest 镜像
To show only running containers use: 
        docker ps
    To show all containers use: 
        docker ps -a
    docker ps 默认显示当前正在运行中的container
    docker ps -a 查看包括已经停止的所有容器
    docker ps -l 显示最新启动的一个容器（包括已停止的）

Container naming:
        sudo docker run --name bob_the_container -i -t ubuntu /bin/bash

Starting a stopped container:
        sudo docker start bob_the_container 
            or 
        sudo docker start aa3f365f0f4e
Attaching to a container:   可以交互式进入一个容器
        So there is an interactive session waiting on our running container
        sudo docker attach bob_the_container


Stopping a daemonized container:
        sudo docker stop daemon_dave
        sudo docker stop c2c4e57c12c4
open new tty:
        sudo docker exec -it torch bash

Creating daemonized containers:
        sudo docker run --name daemon_dave -d ubuntu /bin/sh -c "while ↩
true; do echo hello world; sleep 1; done"
see log:
        sudo docker logs daemon_dave
        sudo docker logs -f daemon_dave

Inspecting the container's processes:
    sudo docker top daemon_dave



Finding out more about our container:
        sudo docker inspect daemon_dave

Deleting a container:
        sudo docker rm 80430f8d0921


让非root用户可以使用：
    sudo groupadd docker

    sudo gpasswd -a $USER docker

    Either do a newgrp docker or log out/in to activate the changes to groups.





