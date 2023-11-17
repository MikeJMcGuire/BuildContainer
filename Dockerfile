FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt -y upgrade && \
  apt install -y git gnupg-agent wget curl net-tools dnsutils iputils-ping

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN apt-key adv --fetch-keys https://download.docker.com/linux/ubuntu/gpg && \
  echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(grep "VERSION_CODENAME=" /etc/os-release | awk -F= {' print $2'} | sed s/\"//g) stable" >> /etc/apt/sources.list && \
  apt update && apt install -y docker-ce-cli && \
  rm -rf /var/lib/apt/lists/*  

COPY *.crt /usr/local/share/ca-certificates

RUN update-ca-certificates


