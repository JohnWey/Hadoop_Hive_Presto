ARG VERSION

FROM bidw/presto_base:${VERSION}
MAINTAINER JohnWey

ADD etc /opt/presto/etc

EXPOSE 8080

WORKDIR /opt/presto
ENTRYPOINT ["./scripts/presto.sh"]
