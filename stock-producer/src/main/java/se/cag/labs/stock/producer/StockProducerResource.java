package se.cag.labs.stock.producer;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import se.cag.labs.kafka.model.Stock;

import java.util.List;

@RestController
@Slf4j
public class StockProducerResource {

    private StockProducerConfiguration configuration;

    @Autowired
    public StockProducerResource(StockProducerConfiguration configuration) {
        this.configuration = configuration;
    }

    @PutMapping("stocks/stock")
    public void produceStock(@RequestBody Stock stock) {
        log.info(stock.toString());
        // create a producer, configuration is already there. and publish a stock value
    }

    @PutMapping("stocks")
    public void produceStock(@RequestBody List<Stock> stocks) {
        log.info(stocks.toString());
        // create a producer, configuration is already there. and publish a stock value
    }


}
