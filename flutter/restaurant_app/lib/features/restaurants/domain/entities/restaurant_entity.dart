import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String coverImageUrl;
  final String address;
  final String type;
  final String cuisineType;
  final String openingTime;
  final String closingTime;
  final bool openNow;

  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.address,
    required this.type,
    required this.cuisineType,
    required this.openingTime,
    required this.closingTime,
    required this.openNow,
  });

  @override
  List<Object?> get props => [id];
}