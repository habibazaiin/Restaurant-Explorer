import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String gender,
    required int level,
  }) {
    return repository.signup(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      gender: gender,
      level: level,
    );
  }
}