import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String gender,
    required int level,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}',
      data: {
        'email': email,
        'password': password,
      },
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String gender,
    required int level,
  }) async {
    final response = await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.signupEndpoint}',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'gender': gender,
        'level': level,
      },
    );
    return UserModel.fromJson(response.data);
  }
}