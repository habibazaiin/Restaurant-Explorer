package backend.mobile.dto;

import lombok.*;

@Getter
@Setter
@Builder
public class RestaurantMapResponse {
    private Long id;
    private String name;
    private double latitude;
    private double longitude;
}