FROM centos:7.7.1908

ENV JAVA_HOME=/etc/alternatives/jre \
ZK_DATA_DIR=/home/zookeeper/data \
ZK_DATA_LOG_DIR=/home/zookeeper/log \
ZK_LOG_DIR=/home/zookeeper \
KAFKA_USER=kafka

# according to http://www.2uo.de/myths-about-urandom/
RUN yum install -y \
       wget \
       java-1.8.0-openjdk-1.8.0.242.b08-1.el7 \
       java-1.8.0-openjdk-devel-1.8.0.242.b08-1.el7 \
    && echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/jre/lib/security/java.security \
    && yum clean all

RUN wget http://apache.mirrors.hoobly.com/kafka/2.5.0/kafka_2.12-2.5.0.tgz
RUN tar -xvzf kafka_2.12-2.5.0.tgz
RUN mv kafka_2.12-2.5.0 /home/kafka-2
RUN useradd $KAFKA_USER
RUN mkdir -p $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZK_LOG_DIR
RUN chown -R "$KAFKA_USER:$KAFKA_USER" /home/kafka $ZK_DATA_DIR $ZK_DATA_LOG_DIR $ZK_LOG_DIR
COPY kafka_zookeeper_setup.sh /home/
RUN chmod 777 /home/kafka_zookeeper_setup.sh
