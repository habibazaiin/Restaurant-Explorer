import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../cubit/search_state.dart';

class SearchMapWidget extends StatelessWidget {
  const SearchMapWidget({
    super.key,
    required this.state,
    required this.onMarkerTap,
  });

  final SearchLoaded state;
  final Function(int index) onMarkerTap;

  @override
  Widget build(BuildContext context) {
    final mapRestaurants = state.mapRestaurants;

    if (mapRestaurants.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              size: 48,
              color: Color(0xFFCCCCCC),
            ),
            SizedBox(height: 12),
            Text(
              'No location data available',
              style: TextStyle(
                color: Color(0xFF999999),
              ),
            ),
          ],
        ),
      );
    }

    final markers = mapRestaurants
        .asMap()
        .entries
        .map((entry) {
      final index = entry.key;
      final restaurant = entry.value;

      return Marker(
        markerId:
            MarkerId(restaurant.id.toString()),
        position: LatLng(
          restaurant.latitude!,
          restaurant.longitude!,
        ),
        infoWindow: InfoWindow(
          title: restaurant.name,
          snippet: restaurant.address,
          onTap: () => onMarkerTap(index),
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        ),
      );
    }).toSet();

    final center = LatLng(
      mapRestaurants.first.latitude!,
      mapRestaurants.first.longitude!,
    );

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 12,
      ),
      markers: markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
    );
  }
}