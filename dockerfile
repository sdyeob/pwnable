FROM ubuntu:18.04
#FROM ubuntu:22.04

ENV PATH="${PATH}:/usr/local/lib/python3.6/dist-packages/bin"
ENV LC_CTYPE=C.UTF-8

WORKDIR /apps_for_pwnable

COPY files pwnable

RUN apt-get update &&\
	apt-get -y upgrade

# [1] Install Packages
RUN apt-get install -y vim \
	gdb \
	git \
	python3 \
	python3-pip \
	python3-dev \
	libssl-dev \
	libffi-dev \
	build-essential \ 
	ruby \
	gcc-multilib \
	tmux \
	sudo \
	binutils # readelf, objdump, strings, nm등이 존재

# [2] sys.stderr.write(f"ERROR: {exc}") 에러 해결
RUN apt-get install -y wget && \
	wget https://bootstrap.pypa.io/pip/3.5/get-pip.py && \
	python3 get-pip.py

RUN python3 -m pip install --upgrade pip && \
	python3 -m pip install --upgrade pwntools

RUN gem install one_gadget

RUN git clone https://github.com/Gallopsled/pwntools.git && \
	git clone https://github.com/JonathanSalwan/ROPgadget.git

RUN git clone https://github.com/pwndbg/pwndbg
WORKDIR /apps_for_pwnable/pwndbg
RUN git checkout 2023.03.19
RUN ./setup.sh


WORKDIR /apps_for_pwnable/pwnable
