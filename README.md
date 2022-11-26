Zeebe Docker Image with integrated Exporters
============================================
![Compatible with: Camunda Platform 8](https://img.shields.io/badge/Compatible%20with-Camunda%20Platform%208-0072Ce)


## Using this Docker Image

This Docker Image is published at [Docker Hub](https://hub.docker.com/repository/docker/hauptmedia/zeebe-with-exporters).

You can simply run the image `hauptmedia/zeebe-with-exporters:latest` to use it.

### Environment Variables

This image is based on the official `camunda/zeebe` Docker Image and just adds exporters to it, so please have a look at the
[Zeebe Documentation](https://docs.camunda.io/docs/self-managed/zeebe-deployment/configuration/environment-variables/)
for the available configuration options.

## Kafka Exporter

For more documentation please look at the [Zeebe Kafka Exporter Project](https://github.com/camunda-community-hub/zeebe-kafka-exporter).

### Example

This will start a single node Zeebe and a single node Kafka instance and runs
[zbcat](https://github.com/hauptmedia/zbcat) to display the Zeebe events in the console.

```shell
docker compose -f kafka/docker-compose.yml up
```

### Exposed Services

| Port   | Service      |
|--------|--------------|
| 26500  | Zeebe gRPC   |
| 9092   | Kafka Broker |

### Environment Variables

| Enviroment Variable                                 | Setting                                    | Description                              |
|-----------------------------------------------------|--------------------------------------------|------------------------------------------|
| SPRING_CONFIG_ADDITIONAL_LOCATION                   | /usr/local/zeebe/config/kafka-exporter.yml | The kafka-exporter.yml must be activated |
| ZEEBE_BROKER_EXPORTERS_KAFKA_ARGS_PRODUCER_SERVERS  | kafka:9092                                 | A list of Kafka Brokers must be provided |

You can override all settings from `kafka-exporter.yml` using environment variables. 

`ZEEBE_BROKER_EXPORTERS_KAFKA_ARGS_PRODUCER_SERVERS`

will for example override 

```yaml
zeebe:
  broker:
    exporters:
      kafka:
        args:
          producer:
            servers: ""

```

## Hazelcast Exporter

For more documentation please look at the [Zeebe Hazelcast Exporter Project](https://github.com/camunda-community-hub/zeebe-hazelcast-exporter).

### Example

This will start a single node Zeebe instance with an integrated single node Hazelcast Cluster instance.

```shell
docker compose -f hazelcast/docker-compose.yml up
```

### Exposed Services

| Port   | Service    |
|--------|------------|
| 26500  | Zeebe gRPC |
| 5701   | Hazelcast  |

### Environment Variables

| Enviroment Variable                        | Default Setting                                | Description                                                                                               |
|--------------------------------------------|------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| SPRING_CONFIG_ADDITIONAL_LOCATION          | /usr/local/zeebe/config/hazelcast-exporter.yml | The hazelcast-exporter.yml must be activated                                                              |
| ZEEBE_HAZELCAST_PORT                       | 5701                                           | Port for Hazelcast                                                                                        |
| ZEEBE_HAZELCAST_NAME                       | zeebe                                          | Name of the ring buffer                                                                                   |
| ZEEBE_HAZELCAST_CAPACITY                   | -1                                             | Capacity of the ring buffer                                                                               |
| ZEEBE_HAZELCAST_TIME_TO_LIVE_IN_SECONDS    | 0                                              | TTL for the messages in the ring buffer                                                                   |
| ZEEBE_HAZELCAST_FORMAT                     | protobuf                                       | Can be json or protobuf                                                                                   |
| ZEEBE_HAZELCAST_ENABLED_VALUE_TYPES        |                                                | Filter list for value types                                                                               |
| ZEEBE_HAZELCAST_ENABLED_RECORD_TYPES       |                                                | Filter list for record types                                                                              |
| ZEEBE_HAZELCAST_REMOTE_ADDRESS             |                                                | If specified this external Hazelcast cluster will be used, otherwise an internal instance will be created |
| ZEEBE_HAZELCAST_CLUSTER_NAME               | dev                                            | Name of Hazelcast cluster                                                                                 |
| ZEEBE_HAZELCAST_REMOTE_CONNECTION_TIMEOUT  | PT30S                                          | Connection timeout                                                                                        |

