import 'package:flutter/material.dart';
import '../cubit/search_state.dart';
import 'search_result_card.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({
    super.key,
    required this.state,
    required this.onRestaurantTap,
  });

  final SearchLoaded state;
  final Function(int index) onRestaurantTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: state.restaurants.length,
      itemBuilder: (_, i) {
        final restaurant = state.restaurants[i];

        return SearchResultCard(
          restaurant: restaurant,
          onTap: () => onRestaurantTap(i),
        );
      },
    );
  }
}