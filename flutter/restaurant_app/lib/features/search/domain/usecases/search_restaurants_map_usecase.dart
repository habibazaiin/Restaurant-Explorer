import '../entities/map_restaurant_entity.dart';
import '../repositories/search_repository.dart';

class SearchRestaurantsMapUseCase {
  final SearchRepository repository;
  SearchRestaurantsMapUseCase(this.repository);

  Future<List<MapRestaurantEntity>> call(String productName) {
    return repository.searchRestaurantsMap(productName);
  }
}