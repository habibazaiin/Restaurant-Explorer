import 'package:flutter/material.dart';

import '../../domain/entities/search_restaurant_entity.dart';
import '../widgets/search_restaurant_card.dart';
import 'search_empty_locations_widget.dart';

class SearchResultsMapList extends StatelessWidget {
  const SearchResultsMapList({
    super.key,
    required this.restaurants,
    required this.onTap,
  });

  final List<SearchRestaurantEntity> restaurants;
  final Function(SearchRestaurantEntity restaurant)
      onTap;

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return const SearchEmptyLocationsWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: restaurants.length,
      itemBuilder: (_, i) {
        final restaurant = restaurants[i];

        return SearchRestaurantCard(
          restaurant: restaurant,
          trailingIcon: Icons.directions,
          trailingLabel: 'Directions',
          onTap: () => onTap(restaurant),
        );
      },
    );
  }
}