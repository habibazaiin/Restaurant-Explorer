import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class DirectionsInfoBar extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final double? distanceKm;
  final VoidCallback onRetry;
  final VoidCallback onDirectionsTap;

  const DirectionsInfoBar({
    super.key,
    required this.isLoading,
    required this.error,
    required this.distanceKm,
    required this.onRetry,
    required this.onDirectionsTap,
  });

  String _formatDistance(double km) {
    if (km < 1) return '${(km * 1000).toStringAsFixed(0)} m';
    return '${km.toStringAsFixed(1)} km';
  }

  String _estimateTime(double km) {
    final minutes = (km / 30 * 60).round();
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final remaining = minutes % 60;
    return '${hours}h ${remaining}min';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: isLoading
          ? const Row(children: [
              SizedBox(
                width: 18, height: 18,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppTheme.primaryColor),
              ),
              SizedBox(width: 12),
              Text('Getting your location...',
                  style: TextStyle(color: Color(0xFF888888))),
            ])
          : error != null
              ? Row(children: [
                  const Icon(Icons.location_off, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(error!,
                        style: const TextStyle(
                            color: Colors.red, fontSize: 13)),
                  ),
                  TextButton(onPressed: onRetry, child: const Text('Retry')),
                ])
              : Row(children: [
                  _InfoChip(
                    icon: Icons.straighten,
                    label: distanceKm != null
                        ? _formatDistance(distanceKm!)
                        : '--',
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 12),
                  _InfoChip(
                    icon: Icons.access_time,
                    label: distanceKm != null
                        ? _estimateTime(distanceKm!)
                        : '--',
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
                      child: const Row(children: [
                        Icon(Icons.directions,
                            color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text('Directions',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                      ]),
                    ),
                  ),
                ]),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 18, color: color),
      const SizedBox(width: 4),
      Text(label,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: color)),
    ]);
  }
}