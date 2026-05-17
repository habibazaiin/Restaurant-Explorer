import 'dart:math';

double calculateDistanceKm(
  double lat1,
  double lng1,
  double lat2,
  double lng2,
) {
  const R = 6371.0;

  final dLat = _toRad(lat2 - lat1);
  final dLng = _toRad(lng2 - lng1);

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRad(lat1)) *
          cos(_toRad(lat2)) *
          sin(dLng / 2) *
          sin(dLng / 2);

  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c;
}

double _toRad(double deg) => deg * pi / 180;

String formatDistance(double km) {
  if (km < 1) return '${(km * 1000).toStringAsFixed(0)} m';
  return '${km.toStringAsFixed(1)} km';
}

String estimateTime(double km) {
  final minutes = (km / 30 * 60).round();

  if (minutes < 60) return '$minutes min';

  final hours = minutes ~/ 60;
  final remaining = minutes % 60;

  return '${hours}h ${remaining}min';
}