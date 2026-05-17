import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'info_chip.dart';

class DirectionsInfoSection extends StatelessWidget {
  const DirectionsInfoSection({
    super.key,
    required this.isLoading,
    required this.error,
    required this.distanceText,
    required this.timeText,
    required this.onRetry,
    required this.onDirectionsTap,
  });

  final bool isLoading;
  final String? error;
  final String distanceText;
  final String timeText;
  final VoidCallback onRetry;
  final VoidCallback onDirectionsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: isLoading
          ? const Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(width: 12),
                Text('Getting your location...',
                    style: TextStyle(color: Color(0xFF888888))),
              ],
            )
          : error != null
              ? Row(
                  children: [
                    const Icon(Icons.location_off,
                        color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        error!,
                        style: const TextStyle(
                            color: Colors.red, fontSize: 13),
                      ),
                    ),
                    TextButton(
                      onPressed: onRetry,
                      child: const Text('Retry'),
                    ),
                  ],
                )
              : Row(
                  children: [
                    InfoChip(
                      icon: Icons.straighten,
                      label: distanceText,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 12),
                    InfoChip(
                      icon: Icons.access_time,
                      label: timeText,
                      color: const Color(0xFF4285F4),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onDirectionsTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.directions,
                                color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Directions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}