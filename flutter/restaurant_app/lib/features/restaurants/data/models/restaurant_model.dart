import '../../domain/entities/restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.coverImageUrl,
    required super.address,
    required super.type,
    required super.cuisineType,
    required super.openingTime,
    required super.closingTime,
    required super.openNow,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      address: json['address'] ?? '',
      type: json['type'] ?? '',
      cuisineType: json['cuisineType'] ?? '',
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
      openNow: json['openNow'] ?? false,
    );
  }
}