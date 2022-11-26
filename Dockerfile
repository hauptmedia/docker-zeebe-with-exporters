ARG ZEEBE_VERSION=8.1.4

FROM alpine:latest as unzipper

ARG ZEEBE_KAFKA_EXPORTER_VERSION=3.1.1

RUN apk add unzip wget curl
RUN curl -L https://github.com/camunda-community-hub/zeebe-kafka-exporter/releases/download/${ZEEBE_KAFKA_EXPORTER_VERSION}/zeebe-kafka-exporter-${ZEEBE_KAFKA_EXPORTER_VERSION}.zip -o /tmp/zeebe-kafka-exporter.zip && \
    unzip /tmp/zeebe-kafka-exporter.zip -d /tmp && \
    mv /tmp/target/nexus-staging/deferred/io/zeebe/zeebe-kafka-exporter/${ZEEBE_KAFKA_EXPORTER_VERSION}/zeebe-kafka-exporter-${ZEEBE_KAFKA_EXPORTER_VERSION}-jar-with-dependencies.jar /opt/zeebe-kafka-exporter.jar

FROM camunda/zeebe:${ZEEBE_VERSION}

ADD kafka/kafka-exporter.yml /usr/local/zeebe/config/kafka-exporter.yml
COPY --from=unzipper /opt/zeebe-kafka-exporter.jar /usr/local/zeebe/lib/
