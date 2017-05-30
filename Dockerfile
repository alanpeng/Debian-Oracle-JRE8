FROM debian:jessie
MAINTAINER Alan Peng <peng.alan@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
&& rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION 8u121
ENV BUILD_VERSION b13

WORKDIR /tmp

RUN apt-get update \
          && apt-get install -y wget \
          && wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/server-jre-8u121-linux-x64.tar.gz" -O server-jre-8-linux-x64.tar.gz \ 
          && tar xzf server-jre-8-linux-x64.tar.gz \
          && mkdir -p /opt/java \
          && mv jdk1.8.0_121 /opt/java \
          && ln -s /opt/java/jdk1.8.0_121 /opt/java/latest \
          && ln -s /opt/java/latest /opt/java/default \
          && update-alternatives --install /usr/bin/java java /opt/java/latest/bin/java 1 \
          && update-alternatives --install /usr/bin/javac javac /opt/java/latest/bin/javac 1 \
          && rm -f server-jre-8-linux-x64.tar.gz \
          && apt-get remove -y wget \
          && apt-get autoremove -y \
          && apt-get clean -y \
          && apt-get autoclean -y

ENV JAVA_HOME /opt/java/latest
ENV PATH $PATH:$JAVA_HOME/bin

WORKDIR /
