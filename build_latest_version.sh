#!/bin/bash

DOCKER_NAME=hauptmedia/zeebe-with-exporters

# this needs the github cli from https://cli.github.com/

if [ "$1" = "--snapshot" ]; then
  ZEBEE_VERSION="SNAPSHOT"
else
  ZEBEE_VERSION=$(gh release list --limit 10 --exclude-drafts --repo camunda/zeebe | cut -f3 | grep -v alpha | grep -v beta | sort | tail -1)
fi

ZEBEE_KAFKA_EXPORTER_VERSION=$(gh release list --exclude-drafts --limit 1 --repo camunda-community-hub/zeebe-kafka-exporter | cut -f3)
ZEBEE_HAZELCAST_EXPORTER_VERSION=$(gh release list --exclude-drafts --limit 1 --repo camunda-community-hub/zeebe-hazelcast-exporter | cut -f3)

echo "Latest Zeebe Version: ${ZEBEE_VERSION}"
echo "Latest Kafka Exporter Version: ${ZEBEE_KAFKA_EXPORTER_VERSION}"
echo "Latest Hazelcast Exporter Version: ${ZEBEE_HAZELCAST_EXPORTER_VERSION}"

docker build -t ${DOCKER_NAME}:${ZEBEE_VERSION} \
--build-arg ZEEBE_VERSION=${ZEBEE_VERSION} \
--build-arg ZEEBE_KAFKA_EXPORTER_VERSION=${ZEBEE_KAFKA_EXPORTER_VERSION} \
--build-arg ZEEBE_HAZELCAST_EXPORTER_VERSION=${ZEBEE_HAZELCAST_EXPORTER_VERSION} \
.

docker tag ${DOCKER_NAME}:${ZEBEE_VERSION} ${DOCKER_NAME}:latest

if [ "$1" = "--push" ] || [ "$2" = "--push" ]; then
  docker push ${DOCKER_NAME}:${ZEBEE_VERSION}
  docker push ${DOCKER_NAME}:latest
fi
