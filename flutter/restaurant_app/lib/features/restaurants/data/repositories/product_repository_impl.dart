import 'package:dio/dio.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getProducts(int restaurantId) async {
    try {
      return await remoteDataSource.getProducts(restaurantId);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Failed to load products');
    }
  }
}