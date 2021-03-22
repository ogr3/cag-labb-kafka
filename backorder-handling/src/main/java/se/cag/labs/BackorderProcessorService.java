package se.cag.labs;

import org.springframework.stereotype.Service;

/**
 * Service that in
 * Iteration 1: Listens to your order kafka topic and prints the orders on stdout...
 * Iteration 2: Streams Kafka topic and sends orders to 2 distinct Sink:s.
 */
@Service
public class BackorderProcessorService {

    private BackorderProcessorConfiguration configuration;

    public BackorderProcessorService(BackorderProcessorConfiguration configuration) {
        this.configuration = configuration;
    }

}
