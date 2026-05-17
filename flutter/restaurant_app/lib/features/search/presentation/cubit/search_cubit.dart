import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/search_restaurant_entity.dart';
import '../../domain/usecases/search_restaurants_usecase.dart';
import '../../domain/usecases/search_restaurants_map_usecase.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRestaurantsUseCase searchRestaurantsUseCase;
  final SearchRestaurantsMapUseCase searchRestaurantsMapUseCase;

  SearchCubit({
    required this.searchRestaurantsUseCase,
    required this.searchRestaurantsMapUseCase,
  }) : super(const SearchInitial());

  /// يعمل call للاتنين في نفس الوقت ويـ merge الداتا
  Future<void> search(String productName) async {
    if (productName.trim().isEmpty) return;
    final query = productName.trim();
    emit(const SearchLoading());

    try {
      // بيعمل الـ calls الاتنين في نفس الوقت
      final results = await Future.wait([
        searchRestaurantsUseCase(query),
        searchRestaurantsMapUseCase(query),
      ]);

      final restaurants = results[0] as List;
      final mapLocations = results[1] as List;

      if (restaurants.isEmpty) {
        emit(SearchEmpty(query));
        return;
      }

      // بيعمل map من id → lat/lng
      final locationMap = {
        for (final loc in mapLocations) loc.id: loc,
      };

      // بيحول RestaurantEntity → SearchRestaurantEntity ويضيف الـ coordinates
      final merged = restaurants.map((r) {
        final loc = locationMap[r.id];
        return SearchRestaurantEntity(
          id: r.id,
          name: r.name,
          description: r.description,
          coverImageUrl: r.coverImageUrl,
          address: r.address,
          type: r.type,
          cuisineType: r.cuisineType,
          openingTime: r.openingTime,
          closingTime: r.closingTime,
          openNow: r.openNow,
          latitude: loc?.latitude,
          longitude: loc?.longitude,
        );
      }).toList();

      emit(SearchLoaded(
        restaurants: merged,
        query: query,
        viewMode: SearchViewMode.list,
      ));
    } catch (e) {
      emit(SearchError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void switchToMap() {
    final current = state;
    if (current is SearchLoaded) {
      emit(current.copyWith(viewMode: SearchViewMode.map));
    }
  }

  void switchToList() {
    final current = state;
    if (current is SearchLoaded) {
      emit(current.copyWith(viewMode: SearchViewMode.list));
    }
  }
}