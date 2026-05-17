package backend.mobile.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalTime;
import java.util.List;

@Entity
@Table(name = "restaurants")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Restaurant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String coverImageUrl;

    private String address;

    @Enumerated(EnumType.STRING)
    private RestaurantType type;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private Double latitude;

    @Column(nullable = false)
    private Double longitude;

    private LocalTime openingTime;

    private LocalTime closingTime;

    @Enumerated(EnumType.STRING)
    private CuisineType cuisineType;

    @OneToMany(mappedBy = "restaurant")
    private List<RestaurantProduct> restaurantProducts;

    public enum RestaurantType {
    RESTAURANT,
    CAFE
    }

    public enum CuisineType {
        FAST_FOOD,
        ITALIAN,
        CHINESE,
        JAPANESE,
        ARABIC,
        INDIAN,
        SEA_FOOD,
        DESSERTS,
        CAFE
    }
}
