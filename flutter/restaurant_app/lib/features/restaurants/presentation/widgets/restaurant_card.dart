import 'package:auth_app/features/restaurants/presentation/screens/restaurant_details_screen.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/restaurant_entity.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  String _formatTime(String time) {
    if (time.isEmpty) return '';
    final parts = time.split(':');
    if (parts.length < 2) return time;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0
        ? 12
        : hour > 12
            ? hour - 12
            : hour;
    return '$displayHour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RestaurantDetailsScreen(restaurant: restaurant),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(128),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                restaurant.coverImageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5A623).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.restaurant,
                    color: Color(0xFFF5A623),
                    size: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _TypeBadge(type: restaurant.type),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 13, color: Color(0xFF888888)),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          restaurant.address,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF888888)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${_formatTime(restaurant.openingTime)} - ${_formatTime(restaurant.closingTime)}',
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF555555)),
                      ),
                      if (restaurant.openNow) ...[
                        const SizedBox(width: 8),
                        const _ActiveBadge(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final isCafe = type.toUpperCase() == 'CAFE';
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 8,
          color: isCafe ? Colors.brown : const Color(0xFFF5A623),
        ),
        const SizedBox(width: 4),
        Text(
          isCafe ? 'Cafe' : 'Restaurant',
          style: TextStyle(
            fontSize: 12,
            color: isCafe ? Colors.brown : const Color(0xFFF5A623),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.circle, size: 8, color: Colors.green),
        SizedBox(width: 3),
        Text(
          'Active Now',
          style: TextStyle(fontSize: 11, color: Colors.green),
        ),
      ],
    );
  }
}
