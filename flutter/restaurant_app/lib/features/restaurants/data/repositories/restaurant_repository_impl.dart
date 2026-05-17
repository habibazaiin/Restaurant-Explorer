import 'package:dio/dio.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_remote_datasource.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;

  RestaurantRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RestaurantEntity>> getRestaurants() async {
    try {
      return await remoteDataSource.getRestaurants();
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Failed to load restaurants');
    }
  }
}