package backend.mobile.dto;

import lombok.*;

@Getter
@Setter
@Builder
public class ProductResponse {

    private Long id;
    private String name;
    private double price;
}