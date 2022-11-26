## Using this Docker Image

This Docker Image is being published at [Docker Hub](https://hub.docker.com/repository/docker/hauptmedia/zeebe-with-exporters).

You can simply run the image `hauptmedia/zeebe-with-exporters:latest` to use it.

### Base Environment Variables

This image is based on the official `camunda/zeebe` Docker Image and just adds exporters to it, so please have a look at the
[Zeebe Documentation](https://docs.camunda.io/docs/self-managed/zeebe-deployment/configuration/environment-variables/)
for the available configuration options.

## Using the Kafka Exporter

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

### Required Environment Variables

| Enviroment Variable                                 | Setting                                    | Description                              |
|-----------------------------------------------------|--------------------------------------------|------------------------------------------|
| SPRING_CONFIG_ADDITIONAL_LOCATION                   | /usr/local/zeebe/config/kafka-exporter.yml | The kafka-exporter yml must be activates |
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