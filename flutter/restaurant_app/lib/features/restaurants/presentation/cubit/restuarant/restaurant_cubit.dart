import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_restaurants_usecase.dart';
import 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final GetRestaurantsUseCase getRestaurantsUseCase;

  RestaurantCubit({required this.getRestaurantsUseCase})
      : super(const RestaurantInitial());

  Future<void> loadRestaurants() async {
    emit(const RestaurantLoading());
    try {
      final restaurants = await getRestaurantsUseCase();
      emit(RestaurantLoaded(restaurants: restaurants, filtered: restaurants));
    } catch (e) {
      emit(RestaurantError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void search(String query) {
    final current = state;
    if (current is RestaurantLoaded) {
      if (query.isEmpty) {
        emit(RestaurantLoaded(
            restaurants: current.restaurants, filtered: current.restaurants));
      } else {
        final filtered = current.restaurants
            .where((r) =>
                r.name.toLowerCase().contains(query.toLowerCase()) ||
                r.address.toLowerCase().contains(query.toLowerCase()) ||
                r.cuisineType.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(RestaurantLoaded(
            restaurants: current.restaurants, filtered: filtered));
      }
    }
  }
}