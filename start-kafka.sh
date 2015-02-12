#!/bin/bash

if [[ -z "${KAFKA_ADVERTISED_PORT}" ]]; then
    export KAFKA_ADVERTISED_PORT=$(docker port `hostname` 9092 | awk -F: '{print $2}')
fi
if [[ -z "${KAFKA_BROKER_ID}" ]]; then
    export KAFKA_BROKER_ID=$KAFKA_ADVERTISED_PORT
fi
if [[ -z "${KAFKA_LOG_DIRS}" ]]; then
    export KAFKA_LOG_DIRS="/kafka/kafka-logs-$KAFKA_BROKER_ID"
fi
if [[ -z "${KAFKA_ZOOKEEPER_CONNECT}" ]]; then
    export KAFKA_ZOOKEEPER_CONNECT=$(env | grep PORT_2181_TCP= | awk -F/ '{print $3}')
fi

for VAR in `env`; do
  if [[ $VAR =~ ^KAFKA_ && ! $VAR =~ ^KAFKA_HOME ]]; then
  	kafka_name=$(echo $VAR | awk -F= '{print $1}' | sed 's/^KAFKA_//' | tr '[:upper:]' '[:lower:]' | tr _ .)
  	kafka_value=$(echo $VAR | awk -F= '{print $2}')

  	# comment out any existing property
  	sed -r -i "s/^(\s*${kafka_name}\s*)=/#\1/g" ${KAFKA_HOME}/config/server.properties

  	# add the new property
  	echo "${kafka_name} = ${kafka_value}" >> ${KAFKA_HOME}/config/server.properties
  fi
done

${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties
