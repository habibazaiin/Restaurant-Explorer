import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/restaurant_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurants();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final Dio dio;

  RestaurantRemoteDataSourceImpl(this.dio);

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.restaurantsEndpoint}',
    );
    final List data = response.data as List;
    return data.map((json) => RestaurantModel.fromJson(json)).toList();
  }
}