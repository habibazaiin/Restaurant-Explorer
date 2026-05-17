import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsMap extends StatelessWidget {
  const DirectionsMap({
    super.key,
    required this.hasLocation,
    required this.initialTarget,
    required this.markers,
    required this.onMapCreated,
    required this.myLocationEnabled,
  });

  final bool hasLocation;
  final LatLng initialTarget;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;
  final bool myLocationEnabled;

  @override
  Widget build(BuildContext context) {
    if (!hasLocation) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off,
                size: 48, color: Color(0xFFCCCCCC)),
            SizedBox(height: 12),
            Text(
              'No location data\nfor this restaurant',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF999999)),
            ),
          ],
        ),
      );
    }

    return GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(
        target: initialTarget,
        zoom: 14,
      ),
      markers: markers,
      myLocationEnabled: myLocationEnabled,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}