#设置编译器 
CC := g++
#CC := nvcc

#头文件 包含目录
INCLUDE_DIRS := ./include /usr/local/cuda/include 
#设置头文件 目录标志
INCLUDE_FLAGS += $(foreach includedir,$(INCLUDE_DIRS), -I$(includedir))

#设置动态链接库名字
LIBRARY_NAME := glog gflags protobuf
#设置标志
LIBRARY_FLAGS += $(foreach libraryname,$(LIBRARY_NAME), -l$(libraryname))

#设置动态链接库 目录
#LIBRARY_DIRS := /usr/local/cuda/lib64
LIBRARY_DIRS_FLAGS += $(foreach librarydir, $(LIBRARY_DIRS),-L$(librarydir))


#设置 cpp obj bin..文件路径
DIR_SRC := ./src/caffe
DIR_SRC_UTIL := ./src/caffe/util
DIR_SRC_TOOLS := ./tools
DIR_SRC_PROTO := ./src/caffe/proto
#obj
DIR_OBJ := ./obj/caffe
DIR_OBJ_UTIL := ./obj/caffe/util
DIR_OBJ_TOOLS := ./obj/tools
DIR_OBJ_PROTO := ./obj/caffe/proto

#bin
DIR_BIN := ./bin

SRC := $(wildcard $(DIR_SRC)/*.cpp) 
SRC_UTIL := $(wildcard $(DIR_SRC_UTIL)/*.cpp) 
SRC_TOOLS := $(wildcard $(DIR_SRC_TOOLS)/*.cpp) 
SRC_PROTO := $(wildcard $(DIR_SRC_PROTO)/*.cc) 


OBJ := $(patsubst %.cpp,$(DIR_OBJ)/%.o,$(notdir $(SRC))) 
OBJ_UTIL := $(patsubst %.cpp,$(DIR_OBJ_UTIL)/%.o,$(notdir $(SRC_UTIL))) 
OBJ_TOOLS := $(patsubst %.cpp,$(DIR_OBJ_TOOLS)/%.o,$(notdir $(SRC_TOOLS))) 
OBJ_PROTO := $(patsubst %.cc,$(DIR_OBJ_PROTO)/%.o,$(notdir $(SRC_PROTO))) 

TARGET := caffe

#目标文件存放位置
BIN_TARGET := ${DIR_BIN}/${TARGET}

#设置 编译 FLAGS
CFLAGS = -g -Wall $(INCLUDE_FLAGS)

#设置 连接 FLAGS
LFLAGS := $(LIBRARY_FLAGS) $(LIBRARY_DIRS_FLAGS)

#连接	LFLAGS一定要放在文件的后面
$(BIN_TARGET) : $(OBJ) $(OBJ_UTIL) $(OBJ_PROTO) $(OBJ_TOOLS)
		$(CC)  \
			$(OBJ) \
			$(OBJ_UTIL) \
			$(OBJ_TOOLS)\
			$(OBJ_PROTO)\
			-o $@  \
			$(LFLAGS)
#编译
${DIR_OBJ}/%.o : ${DIR_SRC}/%.cpp
		$(CC) $(CFLAGS) -c  $< -o $@

${DIR_OBJ_UTIL}/%.o : ${DIR_SRC_UTIL}/%.cpp
		$(CC) $(CFLAGS) -c  $< -o $@

${DIR_OBJ_TOOLS}/%.o : ${DIR_SRC_TOOLS}/%.cpp
		$(CC) $(CFLAGS) -c  $< -o $@

${DIR_OBJ_PROTO}/%.o : ${DIR_SRC_PROTO}/%.cc
		$(CC) $(CFLAGS) -c  $< -o $@
#clean:
    #find ${DIR_OBJ} -name *.o -exec rm -rf {}

#protoc 处理proto文件	
#设置文件 目录
#PROTO_DIR := ./src/caffe/proto
#DST_HED_DIR := ./include/caffe/proto
#DST_CPP_DIR := ./src/caffe/proto

#$(shell protoc -I=$(PROTO_DIR) --cpp_out=$(DST_CPP_DIR) $(PROTO_DIR)/caffe.proto )
#$(shell mv $(DST_HED_DIR)/*.cc $(DST_CPP_DIR))























