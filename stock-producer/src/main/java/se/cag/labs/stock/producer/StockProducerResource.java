package se.cag.labs.stock.producer;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import se.cag.labs.kafka.model.Stock;

import java.util.List;

@RestController
@Slf4j
public class StockProducerResource {

    private StockProducerConfiguration configuration;
    private KafkaTemplate<String, String> template;
    private ObjectMapper mapper = new ObjectMapper();

    @Autowired
    public StockProducerResource(StockProducerConfiguration configuration, KafkaTemplate<String, String> template) {
        this.configuration = configuration;
        this.template = template;
    }

    @PutMapping("stocks/stock")
    public void produceStock(@RequestBody Stock stock) throws JsonProcessingException {

        log.info(mapper.writeValueAsString(stock));

        // publish a stock value, KEYED topic, use sku as key
    }

    @PutMapping("stocks")
    public void produceStock(@RequestBody List<Stock> stocks) throws JsonProcessingException {
        log.info(mapper.writeValueAsString(stocks));
        // publish a stock value, KEYED topic, use sku as key
    }

}
