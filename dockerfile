FROM ubuntu:22.04

WORKDIR /apps_for_pwnable

RUN apt-get update &&\
	apt-get -y upgrade

RUN apt-get install -y vim && \
	apt-get install -y gdb && \
	apt-get install -y python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential && \
	apt-get install -y ruby &&\
	apt-get install -y gcc-multilib &&\
	apt-get install -y binutils # readelf, objdump, strings, nm등이 존재

RUN apt-get install -y wget && \
	wget https://bootstrap.pypa.io/pip/3.5/get-pip.py && \
	python3 get-pip.py

RUN python3 -m pip install --upgrade pip && \
	python3 -m pip install --upgrade pwntools 

RUN gem install one_gadget

RUN git clone https://github.com/Gallopsled/pwntools.git && \
	git clone https://github.com/JonathanSalwan/ROPgadget.git && \
	git clone https://github.com/longld/peda.git 

COPY files pwnable
RUN echo "source /apps_for_pwnable/peda/peda.py" >> ~/.gdbinit

WORKDIR /apps_for_pwnable/pwnable
