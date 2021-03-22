package se.cag.labs;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "kafka")
@Data
public class BackorderProcessorConfiguration {
    private String servers;
    private String inTopic;
    private String packTopic;
    private String backorderTopic;
}
