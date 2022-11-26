## Using the kafka exporter (example)

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
