import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/search_restaurant_entity.dart';

class SearchRestaurantCard extends StatelessWidget {
  final SearchRestaurantEntity restaurant;
  final VoidCallback onTap;
  final IconData trailingIcon;
  final String trailingLabel;

  const SearchRestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    required this.trailingIcon,
    required this.trailingLabel,
  });

  String _formatTime(String time) {
    if (time.isEmpty) return '';
    final parts = time.split(':');
    if (parts.length < 2) return time;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : hour > 12 ? hour - 12 : hour;
    return '$displayHour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final isCafe = restaurant.type.toUpperCase() == 'CAFE';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
                width: 70, height: 70, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 70, height: 70,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.restaurant,
                      color: AppTheme.primaryColor, size: 30),
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
                        child: Text(restaurant.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.ellipsis),
                      ),
                      Row(children: [
                        Icon(Icons.circle,
                            size: 8,
                            color: isCafe
                                ? Colors.brown
                                : AppTheme.primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          isCafe ? 'Cafe' : 'Restaurant',
                          style: TextStyle(
                              fontSize: 12,
                              color: isCafe
                                  ? Colors.brown
                                  : AppTheme.primaryColor),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.location_on,
                        size: 13, color: Color(0xFF888888)),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(restaurant.address,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF888888)),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    Text(
                      '${_formatTime(restaurant.openingTime)} - ${_formatTime(restaurant.closingTime)}',
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF555555)),
                    ),
                    if (restaurant.openNow) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.circle, size: 8, color: Colors.green),
                      const SizedBox(width: 3),
                      const Text('Active Now',
                          style:
                              TextStyle(fontSize: 11, color: Colors.green)),
                    ],
                    const Spacer(),
                    Icon(trailingIcon,
                        size: 14, color: AppTheme.primaryColor),
                    const SizedBox(width: 2),
                    Text(trailingLabel,
                        style: const TextStyle(
                            fontSize: 11, color: AppTheme.primaryColor)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}