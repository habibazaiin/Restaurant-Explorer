package backend.mobile.service;

import backend.mobile.dto.ProductResponse;
import backend.mobile.dto.RestaurantMapResponse;
import backend.mobile.dto.RestaurantResponse;
import backend.mobile.entity.Restaurant;
import backend.mobile.repository.RestaurantRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import java.time.LocalTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RestaurantService {

    private final RestaurantRepository restaurantRepository;

    public List<RestaurantResponse> getAllRestaurants() {
        List<Restaurant> restaurants = restaurantRepository.findAll();

        return restaurants.stream()
                .map(this::mapToResponse)
                .toList();
    }

    public List<ProductResponse> getProductsByRestaurantId(@NonNull Long restaurantId) {
    Restaurant restaurant = restaurantRepository.findById(restaurantId)
            .orElseThrow(() -> new RuntimeException("Restaurant not found"));

        return restaurant.getRestaurantProducts()
                .stream()
                .map(rp -> ProductResponse.builder()
                        .id(rp.getProduct().getId())
                        .name(rp.getProduct().getName())
                        .price(rp.getPrice())
                        .build()
                )
                .toList();
    }

    public List<RestaurantResponse> searchRestaurantsByProductName(String name) {
        List<Restaurant> restaurants =
                restaurantRepository.searchRestaurantsByProductName(name);

        return restaurants.stream()
                .map(this::mapToResponse)
                .toList();
    }

    public List<RestaurantMapResponse> searchRestaurantsOnMapByProductName(String productName) {
        List<Restaurant> restaurants =
                restaurantRepository.searchRestaurantsByProductName(productName);

        return restaurants.stream()
                .map(restaurant -> RestaurantMapResponse.builder()
                        .id(restaurant.getId())
                        .name(restaurant.getName())
                        .latitude(restaurant.getLatitude())
                        .longitude(restaurant.getLongitude())
                        .build()
                )
                .toList();
    }

    private RestaurantResponse mapToResponse(Restaurant restaurant) {

        LocalTime now = LocalTime.now();
        LocalTime open = restaurant.getOpeningTime();
        LocalTime close = restaurant.getClosingTime();

        
        boolean isOpenNow;
        if (close.isAfter(open)) {
            isOpenNow = !now.isBefore(open) && now.isBefore(close);
        } else {
            isOpenNow = !now.isBefore(open) || now.isBefore(close);
        }

        return RestaurantResponse.builder()
                .id(restaurant.getId())
                .name(restaurant.getName())
                .description(restaurant.getDescription())
                .coverImageUrl(restaurant.getCoverImageUrl())
                .address(restaurant.getAddress())
                .type(restaurant.getType().name())
                .cuisineType(restaurant.getCuisineType().name())
                .openingTime(restaurant.getOpeningTime())
                .closingTime(restaurant.getClosingTime())
                .isOpenNow(isOpenNow)
                .build();

    }
    
}
