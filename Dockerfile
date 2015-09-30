FROM       java:8-jre
MAINTAINER Stefan Reuter <docker@reucon.com>

ENV SONATYPE_WORK /sonatype-work
ENV NEXUS_VERSION 2.11.4-01

RUN curl --fail --silent --location --retry 3 \
    https://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz \
  | tar xz -C /opt \
  && mv /opt/nexus-${NEXUS_VERSION} /opt/nexus \
  && rm -rf /opt/nexus/nexus/WEB-INF/plugin-repository/nexus-outreach-plugin-* \
  && chown -R daemon:daemon /opt/nexus

VOLUME ${SONATYPE_WORK}

EXPOSE 8081
WORKDIR /opt/nexus
USER daemon
ENV CONTEXT_PATH /
ENV MAX_HEAP 768m
ENV MIN_HEAP 256m
ENV JAVA_OPTS -server -Djava.net.preferIPv4Stack=true
ENV LAUNCHER_CONF ./conf/jetty.xml ./conf/jetty-requestlog.xml
CMD java \
  -Dnexus-work=${SONATYPE_WORK} -Dnexus-webapp-context-path=${CONTEXT_PATH} \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  -cp 'conf/:lib/*' \
  ${JAVA_OPTS} \
  org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF}
