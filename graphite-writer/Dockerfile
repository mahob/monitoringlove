FROM centos:latest

RUN yum update -y && \
    yum install -y nmap-ncat

RUN mkdir -p /graphite-writer/
ADD ./graphite-writer/* /graphite-writer/
RUN chmod +x /graphite-writer/*

WORKDIR /graphte-writer                   