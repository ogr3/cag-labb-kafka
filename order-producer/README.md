Use this link:

https://www.baeldung.com/spring-kafka

and update the OrderProducerResource / OrderProducerConfiguration,
so that posting and order adds it to kafka.

Two things you have to do:

1. Change the orderTopic setting in application.yml to something of your own
2. Set the server settings in the application.yml to point to the servers i provided.

Once your application is started you can check if your
topic was autocreated by spring properly:

```
$ k-topic --list 
```

And you can see produced messages in realtime with

```
$ k-consumer --topic <your topic name> 
```
