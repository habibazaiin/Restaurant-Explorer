import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(int restaurantId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProducts(int restaurantId) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}/restaurants/$restaurantId/products',
    );
    final List data = response.data as List;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}