import 'package:dio/dio.dart';
import '../../../restaurants/domain/entities/restaurant_entity.dart';
import '../../domain/entities/map_restaurant_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RestaurantEntity>> searchRestaurants(String productName) async {
    try {
      return await remoteDataSource.searchRestaurants(productName);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      throw Exception(
          e.response?.data['message'] ?? 'Search failed');
    }
  }

  @override
  Future<List<MapRestaurantEntity>> searchRestaurantsMap(
      String productName) async {
    try {
      return await remoteDataSource.searchRestaurantsMap(productName);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      throw Exception(
          e.response?.data['message'] ?? 'Map search failed');
    }
  }
}