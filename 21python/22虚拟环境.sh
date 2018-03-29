pip install virtualenv
virtualenv --version

cd my_project_folder
virtualenv my_project   #后面起的名字

选择使用一个Python解释器
    virtualenv -p /usr/bin/python2.7 my_project

创建基于pypy的虚拟环境
virtualenv --no-site-packages -p /home/the5fire/pypy-2.0.2/bin/pypy pypy-env
开始使用虚拟环
    source my_project/bin/activate

    停止使用
        虚拟环境：
            deactivate
        anaconda环境
            source deactivate






