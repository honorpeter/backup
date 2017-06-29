            包含source   
workspace:  软连接      bin     out目录
            WORKSPACE   外部依赖
                new_http_archive(
                name = "gtest",
                url = "https://github.com/etest/archive/release-1.7.0.zip",
                sha256 = "b58cba3659c9e3ff52440297e965f5edffe34b6d0",
                build_file = "gtest.BUILD",
                )
                使用外部依赖 ： new_

BUILD文件：
        包含构建目标的规则 和 makefile基本一样
        每条规则可以包含：
                    name:指定 target
                    srcs：指定依赖其他的target 或则 输入
                    outs：指定输出
                    cmd：指定 怎么又输入变为输出 
                    hdrs = ["hello-greet.h"],
                    deps = [
                        ":hello-greet",
                    ],
                    visibility = ["//main:__pkg__"], 默认只对同一个BUILD可见
                    srcs = glob(["*.cc"]) 包含cc结尾的文件
                    copts = ["-Ithird_party/some_lib"],
                        指定 包含文件路径 相对于WORKSPACE路径

build目标：
        bazel build //main:hello-world
            //main 是想对workspace的目录
            ：hello-world是目标target

查看hello-world依赖：
    bazel query --nohost_deps --noimplicit_deps 'deps(//main:hello-world)' \
            --output graph
        将产生的文字复制到： http://www.webgraphviz.com/ 查看依赖图

        查看tensorflow： 
                bazel query --nohost_deps --noimplicit_deps 'deps(//tensorflow:tensorflow_py)'  --output graph
            
包：package：
        每一个BUILD文件和起所使用到的文件 就是一个包
        一个WORKSPACE中可以包含很多的包










        

