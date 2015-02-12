FROM dockerfile/java:oracle-java8
MAINTAINER savaki

ENV KAFKA_VERSION 0.8.2.0
ENV KAFKA_HOME /opt/kafka_2.10-0.8.2.0

RUN apt-get update && apt-get install -y unzip wget curl git docker.io

VOLUME ["/kafka"]

# install kafka
RUN curl -L -o /tmp/kafka.tar.gz "http://mirrors.ibiblio.org/apache/kafka/${KAFKA_VERSION}/kafka_2.10-${KAFKA_VERSION}.tgz" && \
	(cd /opt ; tar -xzvf /tmp/kafka.tar.gz ) && \
	rm /tmp/kafka.tar.gz

ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD server.properties /opt/kafka_2.10-${KAFKA_VERSION}/config/server.properties

EXPOSE 9092

# settings as per https://kafka.apache.org/08/ops.html
ENV KAFKA_HEAP_OPTS -Xms3072m -Xmx3072m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:CMSInitiatingOccupancyFraction=30 

CMD start-kafka.sh 

