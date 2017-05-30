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
          && wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/server-jre-$JAVA_VERSION-linux-x64.tar.gz" -O server-jre-8-linux-x64.tar.gz \ 
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
