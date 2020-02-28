FROM bidw/hadoop:base_v1.0

MAINTAINER JohnWey <john.w.zhang@yzw.cn>

ENV HADOOP_VERSION 3.2.1
ENV HIVE_VERSION 3.1.2

# install hive
ADD apache-hive-${HIVE_VERSION}-bin.tar.gz /opt
RUN mv /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive


# set environment variable
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/hive
ENV HIVE_CONF_DIR=${HIVE_HOME}/conf
ENV PATH=$PATH:${JAVA_HOME}/bin:${HIVE_HOME}/bin:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin


COPY mysql-connector-java-5.1.47.jar ${HIVE_HOME}/lib

COPY config/* /tmp/

#Custom configuration goes here
RUN mv /tmp/hive-site.xml $HIVE_HOME/conf  && \
    mv /tmp/beeline-log4j2.properties $HIVE_HOME/conf && \
    mv /tmp//hive-env.sh $HIVE_HOME/conf && \
    mv /tmp/hive-exec-log4j2.properties $HIVE_HOME/conf && \
    mv /tmp/hive-log4j2.properties $HIVE_HOME/conf && \
    mv /tmp/ivysettings.xml $HIVE_HOME/conf && \
    mv /tmp/llap-daemon-log4j2.properties $HIVE_HOME/conf && \
    mv ${HIVE_HOME}/lib/guava-19.0.jar ${HIVE_HOME}/lib/guava-19.0.jar_bak && \
    cp ${HADOOP_HOME}/share/hadoop/common/lib/guava-27.0-jre.jar ${HIVE_HOME}/lib/ && \
    mv /tmp/startup_hive.sh /usr/local/bin/ && \
    rm -rf /tmp && \
    chmod +x /usr/local/bin/startup_hive.sh

WORKDIR /usr/local/bin

#CMD [ "/usr/sbin/sshd", "-D"; bash"]
CMD [ "sh", "-c", "service ssh start; bash"]


