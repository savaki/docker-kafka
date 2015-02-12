# docker-kafka

Dockerfile for Apache Kafka

The image is available directly from [https://index.docker.io](https://index.docker.io)

Based on the container, [https://github.com/wurstmeister/kafka-docker](https://github.com/wurstmeister/kafka-docker)

## Usage

By default, the application assumes linked zookeeper container with the name zk.

### Environment Variables

If you want to customze any Kafka parameters, simply add them as environment variables with the prefix KAFKA_.  

**Examples:**

To set this property | Use this env variable 
---- | ----:
log.retention.hours | KAFKA_LOG_RETENTION_HOURS
message.max.bytes | KAFKA_MESSAGE_MAX_BYTES
zookeeper.connect | KAFKA_ZOOKEEPER_CONNECT

 

