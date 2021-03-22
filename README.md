Requirements

- Kafka installed. I will setup servers. Do not bother about starting kafka and zookeeper locally,
no cluster no fun. My Kafka servers are 2.6.1 , with Scala 2.12. 
  - Download the tgz archive https://kafka.apache.org/downloads
  - put it somewhere convenient, most of the helpers I provide will assume that it is 
    located at /opt/kafka on your machine. This makes it very painful to use windows without 
    ubuntu/bash :-). But I hope you figure that one out yourself.
    But for all Linux/Mac users:
    ```
    > curl http://apache.mirrors.spacedump.net/kafka/2.6.1/kafka_2.12-2.6.1.tgz --output /tmp/kafka.tgz
    > cd /opt
    > sudo tar xvfz /tmp/kafka.tgz
    > ln -s kafka_2.12-2.6.1 kafka
    > sudo chown -R dawi:dawi /opt/kafka /opt/kafka_2.12-2.6.1
    ``
  
- Java installed, the demo / lab git project uses Java 11. (that is what I have installed.