ARG VERSION

FROM bidw/presto-base:${VERSION}
MAINTAINER JohnWey

COPY etc /opt/presto/etc
EXPOSE 8081

WORKDIR /opt/presto
ENTRYPOINT [ "./scripts/presto.sh" ]
