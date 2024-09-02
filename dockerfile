FROM ubuntu:16.04
#FROM ubuntu:18.04
#FROM ubuntu:22.04

#FROM ubuntu:19.10@sha256:f332c4057e21ec71cc8b20b05328d476104a069bfa6882877e0920e8140edcf0
#RUN sed -i s/archive.ubuntu.com/old-releases.ubuntu.com/g /etc/apt/sources.list
#RUN sed -i s/security.ubuntu.com/old-releases.ubuntu.com/g /etc/apt/sources.list

#ENV PATH="${PATH}:/usr/local/lib/python3.6/dist-packages/bin"
#ENV LC_CTYPE=C.UTF-8

WORKDIR /apps_for_pwnable

RUN apt-get update && apt-get -y upgrade

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
	binutils # readelf, objdump, strings, nm등이 존재

# [2] sys.stderr.write(f"ERROR: {exc}") 에러 해결
RUN apt-get install -y wget && \
	wget https://bootstrap.pypa.io/pip/3.5/get-pip.py && \
	python3 get-pip.py

RUN python3 -m pip install --upgrade pip && \
	python3 -m pip install --upgrade pwntools

RUN gem install one_gadget

COPY files pwnable

WORKDIR /root

RUN git clone https://github.com/Gallopsled/pwntools.git && \
	git clone https://github.com/JonathanSalwan/ROPgadget.git && \
	git clone https://github.com/scwuaptx/Pwngdb.git && \
	git clone https://github.com/longld/peda.git

RUN cp ./Pwngdb/.gdbinit ./
echo "source ~/peda/peda.py" >> ~/.gdbinit

WORKDIR /apps_for_pwnable/pwnable

