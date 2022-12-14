FROM ubuntu:18.04
ENV buildDeps='software-properties-common git libtool cmake python-dev python3-pip python-pip libseccomp-dev curl'
RUN DEBIAN_FRONTEND=noninteractive && apt-get update
RUN DEBIAN_FRONTEND=noninteractive && apt-get install -y python python3 python-pkg-resources python3-pkg-resources $buildDeps
RUN DEBIAN_FRONTEND=noninteractive && add-apt-repository ppa:openjdk-r/ppa && add-apt-repository ppa:longsleep/golang-backports && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y golang-go openjdk-11-jdk nodejs gcc-9 g++-9 && \
        update-alternatives --install  /usr/bin/gcc gcc /usr/bin/gcc-9 40 && \
        update-alternatives --install  /usr/bin/g++ g++ /usr/bin/g++-9 40 && \
        pip3 install -i https://mirrors.aliyun.com/pypi/simple/ -I --no-cache-dir psutil gunicorn flask requests idna
RUN DEBIAN_FRONTEND=noninteractive && cd /tmp && git clone -b newnew  --depth 1 https://github.com/QingdaoU/Judger.git && cd Judger && \
    mkdir build && cd build && cmake .. && make && make install && cd ../bindings/Python && python3 setup.py install
CMD ["bash"]