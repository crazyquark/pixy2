#!/bin/bash

function WHITE_TEXT {
  printf "\033[1;37m"
}
function NORMAL_TEXT {
  printf "\033[0m"
}
function GREEN_TEXT {
  printf "\033[1;32m"
}
function RED_TEXT {
  printf "\033[1;31m"
}

WHITE_TEXT
echo "########################################################################################"
echo "# Building Python (SWIG) Demos...                                                      #"
echo "########################################################################################"
NORMAL_TEXT

uname -a

TARGET_BUILD_FOLDER=../build

mkdir $TARGET_BUILD_FOLDER
mkdir $TARGET_BUILD_FOLDER/python_demos

if [[ -z ${PYTHON} ]]; then
  PYTHON=python
fi

cd ../src/host/libpixyusb2_examples/python_demos

swig -c++ -python pixy.i
${PYTHON} swig.dat build_ext --inplace -D__LINUX__

# account for the differnt names produces by compilers
mv _pixy.*.so _pixy.so 

files=(../../../../build/python_demos/*.so)
if (( ${#files[@]} )); then
  rm ../../../../build/python_demos/*.so
fi

cp * ../../../../build/python_demos

files=(../../../../build/python_demos/*.so)
if (( ${#files[@]} )); then
  GREEN_TEXT
  printf "SUCCESS "
else
  RED_TEXT
  printf "FAILURE "
fi
echo ""
