import 'package:flutter/material.dart';

import '../../domain/entities/search_restaurant_entity.dart';
import '../widgets/search_restaurant_card.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({
    super.key,
    required this.restaurants,
    required this.onTap,
  });

  final List<SearchRestaurantEntity> restaurants;
  final Function(SearchRestaurantEntity restaurant)
      onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: restaurants.length,
      itemBuilder: (_, i) {
        final restaurant = restaurants[i];

        return SearchRestaurantCard(
          restaurant: restaurant,
          trailingIcon: Icons.restaurant_menu,
          trailingLabel: 'View Menu',
          onTap: () => onTap(restaurant),
        );
      },
    );
  }
}