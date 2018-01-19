cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_FFMPEG=ON -D  WITH_TBB=ON -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules  -D CMAKE_INSTALL_PREFIX=/usr/local -D CMAKE_C_FLAGS="-fPIC" -D CMAKE_CXX_FLAGS="-fPIC" -D CMAKE_SHARED_LINKER_FLAGS="-Wl,-Bsymbolic,-lswresample,-lbz2" ..

ubuntu:
cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_FFMPEG=ON -D  WITH_TBB=ON -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules  -D CMAKE_INSTALL_PREFIX=/usr/local ..

sudo apt-get -y install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get -y install libgtk2.0-dev
sudo apt-get -y install libv4l-dev
sudo apt-get -y install libatlas-base-dev gfortran

build with gpu:
    -D BUILD_opencv_gpu=OFF
    -D WITH_CUDA=OFF
