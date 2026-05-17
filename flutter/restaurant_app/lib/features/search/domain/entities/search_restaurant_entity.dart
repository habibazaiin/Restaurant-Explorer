import 'package:equatable/equatable.dart';

/// يجمع بيانات RestaurantResponse + RestaurantMapResponse
class SearchRestaurantEntity extends Equatable {
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
  final double? latitude;
  final double? longitude;

  const SearchRestaurantEntity({
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
    this.latitude,
    this.longitude,
  });

  bool get hasLocation => latitude != null && longitude != null;

  SearchRestaurantEntity copyWithLocation(double lat, double lng) {
    return SearchRestaurantEntity(
      id: id,
      name: name,
      description: description,
      coverImageUrl: coverImageUrl,
      address: address,
      type: type,
      cuisineType: cuisineType,
      openingTime: openingTime,
      closingTime: closingTime,
      openNow: openNow,
      latitude: lat,
      longitude: lng,
    );
  }

  @override
  List<Object?> get props => [id];
}