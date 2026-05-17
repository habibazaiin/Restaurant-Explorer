import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String gender;
  final int level;

  const UserEntity({
    required this.name,
    required this.email,
    required this.gender,
    required this.level,
  });

  @override
  List<Object?> get props => [name, email, gender, level];
}