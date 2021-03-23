package se.cag.labs.order.consumer;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * Service that in
 * Iteration 1: Listens to your order kafka topic and prints the orders on stdout...
 * Iteration 2: Streams Kafka topic and sends orders to 2 distinct Sink:s.
 */
@Service
@Slf4j
public class OrderProcessorService {

    private OrderProcessorConfiguration configuration;

    public OrderProcessorService(OrderProcessorConfiguration configuration) {
        this.configuration = configuration;
    }

    // a first hint... KafkaListener
}
