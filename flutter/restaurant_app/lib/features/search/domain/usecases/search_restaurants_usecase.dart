import '../../../restaurants/domain/entities/restaurant_entity.dart';
import '../repositories/search_repository.dart';

class SearchRestaurantsUseCase {
  final SearchRepository repository;
  SearchRestaurantsUseCase(this.repository);

  Future<List<RestaurantEntity>> call(String productName) {
    return repository.searchRestaurants(productName);
  }
}