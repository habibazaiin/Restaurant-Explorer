import 'package:equatable/equatable.dart';
import '../../../domain/entities/restaurant_entity.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object?> get props => [];
}

class RestaurantInitial extends RestaurantState {
  const RestaurantInitial();
}

class RestaurantLoading extends RestaurantState {
  const RestaurantLoading();
}

class RestaurantLoaded extends RestaurantState {
  final List<RestaurantEntity> restaurants;
  final List<RestaurantEntity> filtered;

  const RestaurantLoaded({required this.restaurants, required this.filtered});

  @override
  List<Object?> get props => [restaurants, filtered];
}

class RestaurantError extends RestaurantState {
  final String message;
  const RestaurantError(this.message);

  @override
  List<Object?> get props => [message];
}