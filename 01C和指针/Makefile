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



#自动处理 依赖关系

PROJECT := caffe
CXX := g++
build := build/
CAFFE := bin/$(PROJECT)


#sources_cpp += $(shell find src/$(PROJECT) ! -name "test_*.cpp" \
			   #-name "*.cpp")
#找到 全部带有 cpp后缀的文件
sources_cpp += $(shell find src/$(PROJECT) tools -name "*.cpp")
#找到全部带有cc后缀的文件
sources_proto += $(shell find src/$(PROJECT) -name "*.cc")

#需要的 .o file
objects_cpp := ${sources_cpp:.cpp=.o}
objects_proto := ${sources_proto:.cc=.o}

# dependencies files
dependencies_cpp := ${objects_cpp:.o=.d}
dependencies_proto := ${objects_proto:.o=.d}

objects_cpp_build := $(addprefix $(build),$(objects_cpp))
objects_proto_build := $(addprefix $(build),$(objects_proto))

#dependencies files in build directory
dependencies_cpp_build := $(addprefix $(build),$(dependencies_cpp))
dependencies_proto_build := $(addprefix $(build),$(dependencies_proto))


#设置 头文件路径
include_dirs := include /usr/local/cuda/include
CPPFLAGS += $(addprefix -I ,$(include_dirs))
#自动生成依赖
#CPPFLAGS += -MMD -MP
ifneq ($(hh), h)
	CPPFLAGS += -MMD 
endif


#设置动态链接库名字
library_name := glog gflags protobuf boost_system boost_thread cublas\
				curand
#设置标志
LIBRARY_FLAGS += $(addprefix -l ,$(library_name))

#设置 连接 FLAGS
LFLAGS := $(LIBRARY_FLAGS) $(LIBRARY_DIRS_FLAGS)

#为目标
all: $(CAFFE)
	
$(CAFFE): $(objects_cpp_build) $(objects_proto_build)     
		nvcc $(objects_proto_build) $(objects_cpp_build) \
			-o $@\
			$(LFLAGS)

$(build)%.o: %.cpp
	mkdir -p `dirname $@`
	$(CXX) $< $(CPPFLAGS) -c -o $@ 

$(build)%.o: %.cc
	mkdir -p `dirname $@`
	$(CXX) $< $(CPPFLAGS) -c -o $@ 


#inlcude dependencies files in folder build
-include $(dependencies_cpp_build) $(dependencies_proto_build)




MV := mv -f
RM := rm -f
SED := sed


#g++ -M `echo $@ | $(SED) 's/build\/// ; s/d/cpp/'` 
#$(dependencies_cpp_build):
		#mkdir -p `dirname $@`  
		#g++ $(CPPFLAGS) -M `echo $@ | $(SED) 's/build\/// ; s/\.d/\.cpp/'`\
		| $(SED) 's,\($(notdir $*)\.o\) *:,$(dir $@)\1 $@: ,' > $@
		#$(MV) $@.tmp $@
		
#$(dependencies_proto_build):
		#mkdir -p `dirname $@`  
		#g++ $(CPPFLAGS) -M `echo $@ | $(SED) 's/build\/// ; s/\.d/\.cc/'`\
		| $(SED) 's,\($(notdir $*)\.o\) *:,$(dir $@)\1 $@: ,' > $@
		#$(MV) $@.tmp $@


#$(objects_proto_build): 
		#mkdir -p `dirname $@`
		#g++ $(CPPFLAGS) -c `echo $@ | $(SED) 's/build\/// ; s/\.o/\.cc/'`\
			#-o $@
#$(objects_cpp_build): 
		#mkdir -p `dirname $@`
		#g++ $(CPPFLAGS) -c `echo $@ | $(SED) 's/build\/// ; s/\.o/\.cpp/'`\
			#-o $@
























