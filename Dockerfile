FROM jenkins/jenkins:latest

USER root

RUN apt-key adv --fetch-keys https://download.docker.com/linux/debian/gpg && \
  echo "deb [arch=amd64] https://download.docker.com/linux/debian $(grep "VERSION_CODENAME=" /etc/os-release | awk -F= {' print $2'} | sed s/\"//g) stable" >> /etc/apt/sources.list && \
  apt-get update && apt-get install -y docker-ce-cli && \
  rm -rf /var/lib/apt/lists/*  

COPY *.crt /usr/local/share/ca-certificates

RUN update-ca-certificates

USER jenkins
