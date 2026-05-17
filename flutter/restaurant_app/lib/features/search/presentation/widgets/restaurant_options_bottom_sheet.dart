import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../restaurants/domain/entities/restaurant_entity.dart';
import '../../../restaurants/presentation/screens/restaurant_details_screen.dart';
import '../../domain/entities/search_restaurant_entity.dart';
import '../../presentation/screens/direction_screen.dart';
import 'option_tile.dart';

void showRestaurantOptionsBottomSheet(
  BuildContext context,
  SearchRestaurantEntity restaurant,
) {
  final restaurantEntity = RestaurantEntity(
    id: restaurant.id,
    name: restaurant.name,
    description: restaurant.description,
    coverImageUrl: restaurant.coverImageUrl,
    address: restaurant.address,
    type: restaurant.type,
    cuisineType: restaurant.cuisineType,
    openingTime: restaurant.openingTime,
    closingTime: restaurant.closingTime,
    openNow: restaurant.openNow,
  );

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius:
                    BorderRadius.circular(2),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            restaurant.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            restaurant.address,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF888888),
            ),
          ),

          const SizedBox(height: 20),

          OptionTile(
            icon: Icons.restaurant_menu,
            color: AppTheme.primaryColor,
            label: 'View Restaurant',
            subtitle: 'See menu and products',
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      RestaurantDetailsScreen(
                    restaurant: restaurantEntity,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          OptionTile(
            icon: Icons.location_on,
            color: const Color(0xFF4285F4),
            label: 'View Location',
            subtitle:
                'Get distance & directions',
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DirectionsScreen(
                    restaurant: restaurant,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}