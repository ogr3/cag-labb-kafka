package se.cag.labs.kafka.model;

import lombok.Data;

@Data
public class Stock {
    private String sku;
    private int stock;
}
