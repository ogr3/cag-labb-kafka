
# Exercise "Stock Service" 

So first, I have prepared the producer, so you should first just go into the stock-producer/resources/application.yml
and setup the IP addresses of the servers, and your own topic name, then fire it up to get the topics created.

Use links:

https://docs.spring.io/spring-kafka/docs/current/api/org/springframework/kafka/annotation/EnableKafkaStreams.html
https://docs.spring.io/spring-boot/docs/current/reference/html/spring-boot-features.html#boot-features-kafka-streams

and update the StockServiceConfiguration and StockServiceResource,
to use a GlobalKTable / KeyValuePairStore from the kafka topic to serve stocks.

This link contains some hints on which attributes you need to set on the StreamsConfig:
https://stackoverflow.com/questions/51733039/kafka-streams-with-spring-boot

Since the stock-producer have the topic creation code, we can omit that for now.

Things you have to do for this excercise:

1. again, private settings in application.yml
2. Set the server settings in the application.yml to point to the servers i provided.

