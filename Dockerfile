FROM ubuntu:latest
RUN mkdir /workspace
ADD ./workspace /workspace
WORKDIR /workspace
RUN apt-get update
RUN apt-get -y install sudo && \
    sudo apt-get -y install build-essential && \
    sudo apt-get -y install git && \
    sudo apt-get -y install vim && \
    sudo apt-get -y install man && \
    sudo apt-get -y install manpages-dev && \
    apt-get install -y strace
# Do not exclude man pages & other documentation
RUN rm /etc/dpkg/dpkg.cfg.d/excludes
# Reinstall all currently installed packages in order to get the man pages back
RUN apt-get update && \
    dpkg -l | grep ^ii | cut -d' ' -f3 | xargs apt-get install -y --reinstall && \
    rm -r /var/lib/apt/lists/*
RUN sudo apt-get update -y && sudo apt-get install -y libbsd-dev
RUN sudo apt-get install wget && cd /usr/local/src && wget http://www.apuebook.com/src.3e.tar.gz && tar xvfz src.3e.tar.gz && cd apue.3e/ && make && sudo cp include/apue.h /usr/local/include && sudo cp lib/libapue.a /usr/local/lib
# 個々のファイルのコンパイル方法
# -lで準備したapueを指定してコンパイルします。
# gcc ls.c -lapue -Wall -o ls2
# これでls2 にディレクトリを引数で渡せば動く。他のファイルも同様のやり方で動く
