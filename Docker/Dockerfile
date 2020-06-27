FROM centos:7.7.1908

USER root

# /dev/urandom is used as random source, which is prefectly safe
# according to http://www.2uo.de/myths-about-urandom/
RUN yum install -y \
       wget \
       java-1.8.0-openjdk-1.8.0.242.b08-1.el7 \
       java-1.8.0-openjdk-devel-1.8.0.242.b08-1.el7 \
    && echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/jre/lib/security/java.security \
    && yum clean all

ENV JAVA_HOME /etc/alternatives/jre
RUN wget https://downloads.apache.org/flume/1.9.0/apache-flume-1.9.0-bin.tar.gz
RUN tar -xvzf apache-flume-1.9.0-bin.tar.gz
RUN mv apache-flume-1.9.0-bin flume

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda

RUN $HOME/miniconda/bin/conda init
RUN $HOME/miniconda/bin/conda create --name python-flume python=3.7

ENV PATH /root/miniconda/bin:$PATH
RUN echo $PATH
RUN $HOME/miniconda/bin/conda init bash
RUN /bin/bash -c conda activate python-flume
RUN conda install -n python-flume -y pandas
RUN conda install -n python-flume -y scikit-learn
COPY populate_nyc_data.py $HOME/
RUN mkdir $HOME/data

