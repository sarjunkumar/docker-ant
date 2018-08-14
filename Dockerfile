FROM frekele/java:jdk8

MAINTAINER frekele <leandro.freitas@softdevelop.com.br>

ENV ANT_VERSION=1.10.3
ENV ANT_HOME=/opt/ant

# change to tmp folder
WORKDIR /tmp

# Download and extract apache ant to opt folder
RUN wget --no-check-certificate --no-cookies http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
    && wget --no-check-certificate --no-cookies http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz.sha512 \
    && echo "$(cat apache-ant-${ANT_VERSION}-bin.tar.gz.sha512) apache-ant-${ANT_VERSION}-bin.tar.gz" | sha512sum -c \
    && tar -zvxf apache-ant-${ANT_VERSION}-bin.tar.gz -C /opt/ \
    && ln -s /opt/apache-ant-${ANT_VERSION} /opt/ant \
    && rm -f apache-ant-${ANT_VERSION}-bin.tar.gz \
    && rm -f apache-ant-${ANT_VERSION}-bin.tar.gz.sha512

# add executables to path
RUN update-alternatives --install "/usr/bin/ant" "ant" "/opt/ant/bin/ant" 1 && \
    update-alternatives --set "ant" "/opt/ant/bin/ant" 

#Adding Commands to install Git
RUN apt-get update
RUN apt-get -y install git-core

#Adding Git Global Credentials 
RUN git config --global user.name "A0757116"
RUN git config --global user.email arjun.kumar.selvamani@aon.com
    
# Add the files
ADD rootfs /

# change to root folder
WORKDIR /root
