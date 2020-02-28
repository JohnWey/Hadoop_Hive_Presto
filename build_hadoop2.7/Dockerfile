FROM debian:9

MAINTAINER JohnWey <john.w.zhang@yzw.cn>

COPY sources.list /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      vim \
      openjdk-8-jdk \
      openssh-server \
      net-tools \
      curl \
      netcat \
    && rm -rf /var/lib/apt/lists/* && apt-get autoclean

ENV HADOOP_VERSION 3.2.1

# install hadoop
ADD hadoop-${HADOOP_VERSION}.tar.gz /opt

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV PATH=$PATH:${JAVA_HOME}/bin:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin
RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop


# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


# create directory
RUN mkdir -p /hadoop-data/dfs/name && \ 
    mkdir -p /hadoop-data/dfs/data && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml ${HADOOP_HOME}/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml ${HADOOP_HOME}/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml ${HADOOP_HOME}/etc/hadoop/yarn-site.xml && \
    mv /tmp/workers ${HADOOP_HOME}/etc/hadoop/workers && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/stop-hadoop.sh ~/stop-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh && \
    rm -rf /tmp && \
    sed -i 's/mesg n || true/tty -s \&\& mesg n/g'  /root/.profile && \
    # grant privilege
    chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x ${HADOOP_HOME}/sbin/start-dfs.sh && \
    chmod +x ${HADOOP_HOME}/sbin/start-yarn.sh 

# format namenode
RUN ${HADOOP_HOME}/bin/hdfs namenode -format

#CMD [ "/usr/sbin/sshd", "-D"; bash"]
CMD [ "sh", "-c", "service ssh start; bash"]
