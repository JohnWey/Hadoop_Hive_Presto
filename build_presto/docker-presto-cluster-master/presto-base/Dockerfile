FROM debian:9

MAINTAINER JohnWey <john.w.zhang@yzw.cn>

COPY sources.list /etc/apt/sources.list

# install dev tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-8-jdk \
      curl \
      rsync python wget python-pip python-dev build-essential uuid-runtime \
    && rm -rf /var/lib/apt/lists/* && apt-get autoclean
RUN pip install jinja2    

ARG VERSION
ENV PRESTO_VERSION=${VERSION}
ENV PRESTO_HOME=/opt/presto
# ENV BASE_URL=https://repo1.maven.org/maven2


ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin

ADD presto-server-${PRESTO_VERSION}.tar.gz /opt
# RUN wget -q ${BASE_URL}/io/prestosql/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz
# RUN tar xvzf presto-server-${PRESTO_VERSION}.tar.gz -C /usr/local/
RUN mv /opt/presto-server-${PRESTO_VERSION} $PRESTO_HOME

ADD scripts ${PRESTO_HOME}/scripts
RUN chmod +x ${PRESTO_HOME}/scripts/*.sh

# Create data dir
RUN mkdir -p $PRESTO_HOME/data
VOLUME ["$PRESTO_HOME/data"]
