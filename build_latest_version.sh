#!/bin/bash

DOCKER_NAME=hauptmedia/zeebe

ZEBEE_VERSION=$(gh release list --exclude-drafts --limit 1 --repo camunda/zeebe | cut -f1)
ZEBEE_KAFKA_EXPORTER_VERSION=$(gh release list --exclude-drafts --limit 1 --repo camunda-community-hub/zeebe-kafka-exporter | cut -f1)

echo "Latest Zeebe Release Version: ${ZEBEE_VERSION}"
echo "Latest Zeebe Kafka Exporter Version: ${ZEBEE_KAFKA_EXPORTER_VERSION}"

docker build -t ${DOCKER_NAME}:${ZEBEE_VERSION} \
--build-arg ZEEBE_VERSION=${ZEBEE_VERSION} \
--build-arg ZEEBE_KAFKA_EXPORTER_VERSION=${ZEBEE_KAFKA_EXPORTER_VERSION} \
.

docker tag ${DOCKER_NAME}:${ZEBEE_VERSION} ${DOCKER_NAME}:latest