FROM centos:7.7.1908
WORKDIR /app
RUN chown -R root /app
USER root

RUN yum install -y \
       wget \
       java-1.8.0-openjdk-1.8.0.242.b08-1.el7 \
       java-1.8.0-openjdk-devel-1.8.0.242.b08-1.el7 \
    && echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/jre/lib/security/java.security \
    && yum clean all

ARG kafka_version=2.5.0
ARG scala_version=2.12

ENV JAVA_HOME=/etc/alternatives/jre \
ZK_DATA_DIR=/app/zookeeper/data \
ZK_DATA_LOG_DIR=/app/zookeeper/log \
ZK_LOG_DIR=/app/zookeeper \
KAFKA_VERSION=$kafka_version \
SCALA_VERSION=$scala_version \
KAFKA_HOME=/app/kafka

ENV PATH=${PATH}:${KAFKA_HOME}/bin

RUN wget http://apache.mirrors.hoobly.com/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
RUN tar -xvzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /app
RUN mkdir -p $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZK_LOG_DIR
RUN ln -s kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}
COPY kafka_zookeeper_setup.sh .
RUN chmod -R 777 *

RUN sed -i -e '/^dataDir=/d' "$KAFKA_HOME/config/zookeeper.properties"
RUN sed -i -e '/^clientPort=/d' "$KAFKA_HOME/config/zookeeper.properties"
RUN sed -i -e '/^maxClientCnxns=/d' "$KAFKA_HOME/config/zookeeper.properties"
RUN sed -i -e '/^admin.enableServer=/d' "$KAFKA_HOME/config/zookeeper.properties"