package se.cag.labs.kafka.stock;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import se.cag.labs.kafka.model.Stock;

@RestController
@Slf4j
public class StockServiceResource {

    private StockServiceConfiguration configuration;

    public StockServiceResource(StockServiceConfiguration configuration) {
        this.configuration = configuration;
    }

    @GetMapping("stocks/{sku}")
    public Stock getStock(@PathVariable String sku) {
        log.info(sku);
        return null;
    }

}
