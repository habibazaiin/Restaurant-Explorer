import 'package:equatable/equatable.dart';
import '../../domain/entities/search_restaurant_entity.dart';

enum SearchViewMode { list, map }

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

/// State واحد بيحمل كل البيانات + الـ view mode
class SearchLoaded extends SearchState {
  final List<SearchRestaurantEntity> restaurants;
  final String query;
  final SearchViewMode viewMode;

  const SearchLoaded({
    required this.restaurants,
    required this.query,
    required this.viewMode,
  });

  bool get isListMode => viewMode == SearchViewMode.list;

  /// فلتر المطاعم اللي عندها coordinates للـ map
  List<SearchRestaurantEntity> get mapRestaurants =>
      restaurants.where((r) => r.hasLocation).toList();

  SearchLoaded copyWith({SearchViewMode? viewMode}) {
    return SearchLoaded(
      restaurants: restaurants,
      query: query,
      viewMode: viewMode ?? this.viewMode,
    );
  }

  @override
  List<Object?> get props => [restaurants, query, viewMode];
}

class SearchEmpty extends SearchState {
  final String query;
  const SearchEmpty(this.query);
  @override
  List<Object?> get props => [query];
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
  @override
  List<Object?> get props => [message];
}