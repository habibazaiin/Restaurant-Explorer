package backend.mobile.dto;

import java.time.LocalTime;
import java.util.List;

import lombok.*;

@Getter
@Setter
@Builder
public class RestaurantResponse {

    private Long id;
    private String name;
    private String description;
    private String coverImageUrl;
    private String address;
    private String type;
    private String cuisineType;
    private LocalTime openingTime;
    private LocalTime closingTime;
    private boolean isOpenNow;
    private List<ProductResponse> products;

}