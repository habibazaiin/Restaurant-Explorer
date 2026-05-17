import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../restaurants/data/models/restaurant_model.dart';
import '../models/map_restaurant_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<RestaurantModel>> searchRestaurants(String productName);
  Future<List<MapRestaurantModel>> searchRestaurantsMap(String productName);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio dio;
  SearchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<RestaurantModel>> searchRestaurants(String productName) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.searchEndpoint}',
      queryParameters: {'productName': productName},
    );
    final List data = response.data as List;
    return data.map((json) => RestaurantModel.fromJson(json)).toList();
  }

  @override
  Future<List<MapRestaurantModel>> searchRestaurantsMap(
      String productName) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.mapSearchEndpoint}',
      queryParameters: {'productName': productName},
    );
    final List data = response.data as List;
    return data.map((json) => MapRestaurantModel.fromJson(json)).toList();
  }
}