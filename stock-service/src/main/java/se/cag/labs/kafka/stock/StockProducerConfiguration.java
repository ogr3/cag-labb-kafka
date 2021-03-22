package se.cag.labs.kafka.stock;

import lombok.Data;
import org.springframework.context.annotation.Configuration;

@Configuration
@Data
public class StockProducerConfiguration {
    private String servers;
    private String topic;
}
