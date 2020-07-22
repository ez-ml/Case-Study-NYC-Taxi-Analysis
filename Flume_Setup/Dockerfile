FROM centos:7.7.1908

# /dev/urandom is used as random source, which is prefectly safe
# according to http://www.2uo.de/myths-about-urandom/
RUN yum install -y \
       wget \
       bzip2 \
       java-1.8.0-openjdk-1.8.0.242.b08-1.el7 \
       java-1.8.0-openjdk-devel-1.8.0.242.b08-1.el7 \
    && echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/jre/lib/security/java.security \
    && yum clean all

ENV JAVA_HOME /etc/alternatives/jre
ENV PATH /opt/conda/bin:$PATH

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc


RUN wget https://downloads.apache.org/flume/1.9.0/apache-flume-1.9.0-bin.tar.gz
RUN tar -xvzf apache-flume-1.9.0-bin.tar.gz
RUN mv apache-flume-1.9.0-bin flume
RUN mv flume/conf/flume-env.sh.template flume/conf/flume-env.sh
RUN echo "export JAVA_OPTS=\"-Xms2048m -Xmx12392m -XX:MaxDirectMemorySize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC\"" >> flume/conf/flume-env.sh

COPY populate_nyc_data.py $HOME/
RUN mkdir $HOME/data

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

RUN conda create --name python-flume python=3.7
#RUN conda install -n python-flume -y pandas
#RUN conda install -n python-flume -y scikit-learn

RUN /bin/bash -c ". activate python-flume && \
    pip install kafka-python && \
    conda install pandas && \
    conda install scikit-learn"

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
