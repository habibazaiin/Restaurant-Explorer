package backend.mobile.repository;

import backend.mobile.entity.Restaurant;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface RestaurantRepository extends JpaRepository<Restaurant, Long> {
        @Query("""
        SELECT DISTINCT r
        FROM Restaurant r
        JOIN r.restaurantProducts rp
        JOIN rp.product p
        WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :name, '%'))
    """)
    List<Restaurant> searchRestaurantsByProductName(@Param("name") String name);
}