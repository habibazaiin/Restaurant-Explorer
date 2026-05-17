import '../../domain/entities/map_restaurant_entity.dart';

class MapRestaurantModel extends MapRestaurantEntity {
  const MapRestaurantModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
  });

  factory MapRestaurantModel.fromJson(Map<String, dynamic> json) {
    return MapRestaurantModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }
}