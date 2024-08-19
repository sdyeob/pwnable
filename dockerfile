# Base Image를 의미한다.
FROM ubuntu:16.04

# 작업 디렉토리 설정
WORKDIR /apps_for_pwnable

RUN apt-get update &&\
	apt-get -y upgrade

RUN apt-get install -y vim && \
	apt-get install -y gdb && \
	apt-get install -y python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential && \
	apt-get install -y binutils # readelf, objdump, strings, nm등이 존재

# sys.stderr.write(f"ERROR: {exc}") 에러 해결
RUN apt-get install -y wget && \
	wget https://bootstrap.pypa.io/pip/3.5/get-pip.py && \
	python3 get-pip.py

RUN python3 -m pip install --upgrade pip && \
	python3 -m pip install --upgrade pwntools 

 # 해당 url로부터 git clone을 한다.
RUN git clone https://github.com/Gallopsled/pwntools.git && \
	git clone https://github.com/JonathanSalwan/ROPgadget.git && \
	git clone https://github.com/longld/peda.git

# 호스트 파일 시스템에서 파일이나 디렉토리를 이미지 내부로 복사 (Docker file이 존재하는 디렉토리가 기준인 것 같다.)
COPY files pwnable
RUN echo "source /apps_for_pwnable/peda/peda.py" >> ~/.gdbinit

WORKDIR /apps_for_pwnable/pwnable
