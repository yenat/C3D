# 1. sudo docker build --no-cache -t c3d .
FROM ubuntu:14.04


# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget

# Change to the /tmp directory
RUN cd /tmp && \
# Download run file
  wget http://developer.download.nvidia.com/compute/cuda/7_0/Prod/local_installers/cuda_7.0.28_linux.run && \
# Make the run file executable and extract
  chmod +x cuda_*_linux.run && ./cuda_*_linux.run -extract=`pwd` && \
# Install CUDA drivers (silent, no kernel)
  ./NVIDIA-Linux-x86_64-*.run -s --no-kernel-module && \
# Install toolkit (silent)  
  ./cuda-linux64-rel-*.run -noprompt && \
# Clean up
  rm -rf *

# Add to path
ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

ADD script /home
RUN ./home/opencv.sh
RUN ./home/boost.sh
RUN apt-get install -y libgflags-dev
RUN apt-get install -y libgoogle-glog-dev


RUN apt-get install -y libblas3 
RUN apt-get install -y libatlas-base-dev 
RUN apt-get install -y liblmdb-dev

RUN wget http://crcv.ucf.edu/data/UCF101/UCF101.rar



