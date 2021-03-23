
# Exercise "Order Consumer" 

Use this link:

https://www.baeldung.com/spring-kafka

and update the OrderProcessorResource / OrderProcessorConfiguration,
to consume orders created from the kafka topic.

* first we just consume and log the orders, to get the feel of it.

Since the producer have the topic creation code, we can omit that for now.

Things you have to do for this excercise:

1. Change the kafka.inTopic (we use this first) setting in application.yml to something of your own (same as in order-producer...)
2. Set the kafka.groupId in application.yml to your own.
3. Set the server settings in the application.yml to point to the servers i provided.

If you have tested your order-producer, there should already be orders to 
consume, so when you fire it up for the first time it depends a bit how you 
configured your consumer factory, default is 'latest', but 'earliest' gives a
different behaviour:

https://kafka.apache.org/24/javadoc/constant-values.html#org.apache.kafka.clients.consumer.ConsumerConfig.AUTO_OFFSET_RESET_CONFIG

```
   props.put(
          ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, 
          'earliest');
```

or 

```
   props.put(
          ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, 
          'latest');
```

Once your application is started you can find your consumer group here:

```
$ k-groups --list 
```

And you can see which offset your consumer group is at here, if you have lag etc.

```
$ k-groups --describe --group <your group name> 
```

A test you can make is to:

1. Fire up your consumer for the first time, that way it will consume all messages or start at the end, and then command above will say lag = 0 for your consumer group.
2. Then shut down your consumer.
3. Then add an order with the order-producer.
4. Now the command above should say lag = 1, there is one message not consumed yet for that consumer group.
5. When you fire up your order-processor again, it will immediately consume the order and lag = 0 will be back...

   
# Exercise "Streaming Orders"

Now it is time to actually implement a streaming application. So we will simply
create a streaming application with a latch that actually 