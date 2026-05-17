import '../../../restaurants/domain/entities/restaurant_entity.dart';
import '../entities/map_restaurant_entity.dart';

abstract class SearchRepository {
  Future<List<RestaurantEntity>> searchRestaurants(String productName);
  Future<List<MapRestaurantEntity>> searchRestaurantsMap(String productName);
}