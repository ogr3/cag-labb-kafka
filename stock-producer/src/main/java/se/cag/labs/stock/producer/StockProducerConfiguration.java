package se.cag.labs.stock.producer;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "kafka")
@Data
public class StockProducerConfiguration {
    private String servers;
    private String topic;
    private int replication;
    private int partitions;
}
