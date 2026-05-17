import 'package:auth_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:flutter/material.dart';

class RestaurantDetailsScreenHeader extends StatelessWidget {
  const RestaurantDetailsScreenHeader({
    super.key,
    required this.restaurant,
  });

  final RestaurantEntity restaurant;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: const Color(0xFFF5A623),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back,
              color: Color(0xFF1A1A1A), size: 20),
        ),
      ),
      title: Text(
        restaurant.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          restaurant.coverImageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFFF5A623).withOpacity(0.3),
            child: const Icon(Icons.restaurant,
                color: Color(0xFFF5A623), size: 60),
          ),
        ),
      ),
    );
  }
}