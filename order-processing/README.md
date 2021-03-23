Use this link:

https://www.baeldung.com/spring-kafka

and update the OrderProcessorResource / OrderProcessorConfiguration,
to consume orders created from the kafka topic.

This will be done in 2 different excersises/steps, 

1) first we just consume and log the orders, to get the feel of it.
2) we will stream it a bit...

I would suggest that you actually also have the topic create code in it
for consistency when running on a different cluster.

Things you have to do for the first excercise:

1. Change the inTopic (we use this first) setting in application.yml to something of your own (same as in order-producer...)
2. Set the groupId in application.yml to your own.
2. Set the server settings in the application.yml to point to the servers i provided.
3. Whereever you need to use a consumerGroup string, use a unique one as well...

If you have tested your order-producer, there should already be orders to 
consume, so when you fire it up for the first time it should be logging those order directly.

Once your application is started you can find your consumer group here:

```
$ k-groups --list 
```

And you can see which offset your consumer group is at here, if you have lag etc.

```
$ k-groups --describe --group <your group name> 
```

A test you can make is to:

1. Fire up your consumer for the first time, that way it will consume all messages, and the command above will say lag = 0 for your consumer group.
2. Then shut down your consumer.
3. Then add an order with the order-producer.
4. Now the command above should say lag = 1, there is one message not consumed yet for that consumer group.

   
