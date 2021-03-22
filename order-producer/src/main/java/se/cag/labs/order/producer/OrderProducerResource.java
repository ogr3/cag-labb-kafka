package se.cag.labs.order.producer;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import se.cag.labs.kafka.model.Order;

@RestController
@Slf4j
public class OrderProducerResource {

    private OrderProducerConfiguration configuration;

    private ObjectMapper mapper = new ObjectMapper();

    public OrderProducerResource(OrderProducerConfiguration configuration) {
        this.configuration = configuration;
    }

    @PostMapping("orders/order")
    public void produceOrder(@RequestBody Order order) {
        log.info(order.toString());
        // Just dump order on kafka for processing.
    }

}
