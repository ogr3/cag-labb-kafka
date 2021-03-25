KAFKA_HOME="/opt/kafka/active"
alias k-config-topic="${KAFKA_HOME}/bin/kafka-configs.sh --zookeeper ${ZOOKEEPER} --entity-type topics --entity-name "
alias k-topic="${KAFKA_HOME}/bin/kafka-topics.sh --zookeeper ${ZOOKEEPER} "
alias k-consumer="${KAFKA_HOME}/bin/kafka-console-consumer.sh --bootstrap-server ${KAFKA} "
alias k-groups="${KAFKA_HOME}/bin/kafka-consumer-groups.sh --bootstrap-server ${KAFKA} "
alias k-producer="${KAFKA_HOME}/bin/kafka-console-producer.sh --broker-list ${KAFKA} --topic "

#alias k-config-topic='${KAFKA_HOME}/bin/kafka-configs.sh --zookeeper 192.168.1.52:2181,192.168.1.53:2181,192.168.1.54:2181 --entity-type topics --entity-name '
#alias k-topic='${KAFKA_HOME}/bin/kafka-topics.sh --zookeeper 192.168.1.52:2181,192.168.1.53:2181,192.168.1.54:2181 '
#alias k-consumer='${KAFKA_HOME}/bin/kafka-console-consumer.sh --bootstrap-server 192.168.1.52:9092,192.168.1.53:9092,192.168.1.54:9092 '
#alias k-groups='${KAFKA_HOME}/bin/kafka-consumer-groups.sh --bootstrap-server 192.168.1.52:9092,192.168.1.53:9092,192.168.1.54:9092 '
#alias k-producer='${KAFKA_HOME}/bin/kafka-console-producer.sh --broker-list 192.168.1.52:9092,192.168.1.53:9092,192.168.1.54:9092 --topic '

# tail:                  k-consumer -topic <>
# less:                  k-consumer --from-beginning -topic <>
# list consumers:        k-groups --list
# reset consumer group:  k-groups --reset-offsets <to where> --group <> --topic <> --execute
# current group offset:  k-groups --describe --new-consumer --group <>
