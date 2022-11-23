sudo update-alternatives --auto --config x86_64-w64-mingw32-gcc
sudo update-alternatives --auto  --config x86_64-w64-mingw32-g++
sudo update-alternatives --auto --config x86_64-w64-mingw32-gfortran
sudo update-alternatives --auto --config x86_64-w64-mingw32-gnat

sudo update-alternatives --auto --config i686-w64-mingw32-gcc
sudo update-alternatives --auto --config i686-w64-mingw32-g++
sudo update-alternatives --auto --config i686-w64-mingw32-gfortran
sudo update-alternatives --auto --config i686-w64-mingw32-gnat


#进入工作目录
cd /Volumes/aapt
#使用cmake生成linux构建文件，并最小化编译产物
cmake -H"./" -B"./build-cmake-linux" -DCMAKE_BUILD_TYPE=MinSizeRel
#使用linux环境生成aapt2所需的头文件
cmake --build "./build-cmake-linux" --target protobuffer_h -- -j 8

#使用cmake生成windows交叉编译构建文件，并最小化编译产物
cmake -H"./" -B"./build-cmake-windows" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=windows.toolchain.cmake

#编译aapt
# cmake --build "./build-cmake-windows" --target aapt -- -j 8
#编译aapt2
cmake --build "./build-cmake-windows" --target aapt2 -- -j 8
#编译aapt2_jni
# cmake --build "./build-cmake-windows" --target aapt2_jni -- -j 8
#最终windows下的可执行文件和动态库生成都位于build-cmake-windows目录下