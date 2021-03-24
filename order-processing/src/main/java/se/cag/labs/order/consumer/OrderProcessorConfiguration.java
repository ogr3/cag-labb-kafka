package se.cag.labs.order.consumer;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "kafka")
@Data
public class OrderProcessorConfiguration {
    private String servers;
    private String groupId;
    private String inTopic;
    private String packTopic;
    private String backorderTopic;
    private String applicationId;
}
