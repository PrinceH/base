FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
ENV buildDeps='software-properties-common git libtool cmake python-dev python3-pip python-pip libseccomp-dev curl'
RUN apt-get update
RUN apt-get install -y python python3 python-pkg-resources python3-pkg-resources $buildDeps
RUN add-apt-repository ppa:openjdk-r/ppa && add-apt-repository ppa:longsleep/golang-backports && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y golang-go openjdk-11-jdk nodejs gcc-9 g++-9 && \
        update-alternatives --install  /usr/bin/gcc gcc /usr/bin/gcc-9 40 && \
        update-alternatives --install  /usr/bin/g++ g++ /usr/bin/g++-9 40 && \
        pip3 install -i https://mirrors.aliyun.com/pypi/simple/ -I --no-cache-dir psutil gunicorn flask requests idna
RUN cd /tmp && git clone -b newnew  --depth 1 https://github.com/QingdaoU/Judger.git && cd Judger && \
    mkdir build && cd build && cmake .. && make && make install && cd ../bindings/Python && python3 setup.py install && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /code && \
    useradd -u 12001 compiler && useradd -u 12002 code && useradd -u 12003 spj && usermod -a -G code spj