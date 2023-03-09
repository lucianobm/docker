FROM ubuntu:latest

RUN apt-get update \
    && apt-get -y install python3-pip \
    && pip3 install boto3 \
    && apt-get -y install git \
    && apt-get install -y iputils-ping

RUN git clone https://github.com/lucianobm/python_boto3.git
