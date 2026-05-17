import 'package:dio/dio.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      return await remoteDataSource.login(email: email, password: password);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  @override
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String gender,
    required int level,
  }) async {
    try {
      return await remoteDataSource.signup(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        gender: gender,
        level: level,
      );
    } on DioException catch (e) {
      print('=== SIGNUP DIO ERROR ===');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      print('Error type: ${e.type}');
      print('Error message: ${e.message}');
      print('=======================');

      String message = 'Signup failed';
      if (e.response?.data is Map) {
        message = e.response?.data['message'] ??
            e.response?.data['error'] ??
            'Signup failed';
      } else if (e.response?.data is String) {
        message = e.response?.data;
      } else if (e.type == DioExceptionType.connectionError) {
        message = 'Cannot connect to server. Check your URL.';
      }
      throw Exception(message);
    } catch (e) {
      print('=== SIGNUP UNKNOWN ERROR: $e ===');
      throw Exception(e.toString());
    }
  }
}
