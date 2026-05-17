package backend.mobile.controller;

import backend.mobile.dto.ProductResponse;
import backend.mobile.dto.RestaurantMapResponse;
import backend.mobile.dto.RestaurantResponse;
import backend.mobile.service.RestaurantService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/restaurants")
public class RestaurantController {

    private final RestaurantService restaurantService;

    public RestaurantController(RestaurantService restaurantService) {
        this.restaurantService = restaurantService;
    }

    @GetMapping
    public ResponseEntity<List<RestaurantResponse>> getAllRestaurants() {
        return ResponseEntity.ok(restaurantService.getAllRestaurants());
    }

    @GetMapping("/{id}/products")
    public List<ProductResponse> getRestaurantProducts(@PathVariable Long id) {
        return restaurantService.getProductsByRestaurantId(id);
    }

    @GetMapping("/search")
    public List<RestaurantResponse> searchByProductName(@RequestParam String productName) {
        return restaurantService.searchRestaurantsByProductName(productName);
    }

    @GetMapping("/map/search")
    public List<RestaurantMapResponse> searchMap(@RequestParam String productName) {
        return restaurantService.searchRestaurantsOnMapByProductName(productName);
    }
}