import 'dart:math';
import 'package:auth_app/core/utils/distance_utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/search_restaurant_entity.dart';

import '../widgets/directions_header.dart';
import '../widgets/directions_info_section.dart';
import '../widgets/directions_map.dart';


class DirectionsScreen extends StatefulWidget {
  final SearchRestaurantEntity restaurant;

  const DirectionsScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<DirectionsScreen> createState() => _DirectionsScreenState();
}

class _DirectionsScreenState extends State<DirectionsScreen> {
  GoogleMapController? _mapController;
  Position? _userPosition;

  bool _loadingLocation = true;
  String? _locationError;
  double? _distanceKm;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          setState(() {
            _locationError = 'Location permission denied';
            _loadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationError =
              'Permission permanently denied. Enable it from settings.';
          _loadingLocation = false;
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _userPosition = position;
        _loadingLocation = false;

        if (widget.restaurant.hasLocation) {
          _distanceKm = calculateDistanceKm(
            position.latitude,
            position.longitude,
            widget.restaurant.latitude!,
            widget.restaurant.longitude!,
          );
        }
      });

      if (_mapController != null) {
        _fitBounds();
      }
    } catch (_) {
      setState(() {
        _locationError = 'Could not get location';
        _loadingLocation = false;
      });
    }
  }

  void _fitBounds() {
    if (_userPosition == null || !widget.restaurant.hasLocation) return;

    final userLat = _userPosition!.latitude;
    final userLng = _userPosition!.longitude;

    final restLat = widget.restaurant.latitude!;
    final restLng = widget.restaurant.longitude!;

    final bounds = LatLngBounds(
      southwest: LatLng(
        min(userLat, restLat),
        min(userLng, restLng),
      ),
      northeast: LatLng(
        max(userLat, restLat),
        max(userLng, restLng),
      ),
    );

    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 60),
    );
  }

  Future<void> _openGoogleMaps() async {
    if (!widget.restaurant.hasLocation) return;

    final lat = widget.restaurant.latitude!;
    final lng = widget.restaurant.longitude!;

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=$lat,$lng'
      '&travelmode=driving',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.restaurant;

    final markers = <Marker>{};

    if (r.hasLocation) {
      markers.add(
        Marker(
          markerId: const MarkerId('restaurant'),
          position: LatLng(r.latitude!, r.longitude!),
          infoWindow: InfoWindow(
            title: r.name,
            snippet: r.address,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
      );
    }

    if (_userPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('user'),
          position: LatLng(
            _userPosition!.latitude,
            _userPosition!.longitude,
          ),
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      );
    }

    final initialTarget = r.hasLocation
        ? LatLng(r.latitude!, r.longitude!)
        : const LatLng(30.0444, 31.2357);

    final distanceText = _distanceKm != null
        ? formatDistance(_distanceKm!)
        : '--';

    final timeText = _distanceKm != null
        ? estimateTime(_distanceKm!)
        : '--';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            DirectionsHeader(
              name: r.name,
              address: r.address,
              onBack: () => Navigator.pop(context),
            ),

            //  Info section
            DirectionsInfoSection(
              isLoading: _loadingLocation,
              error: _locationError,
              distanceText: distanceText,
              timeText: timeText,
              onRetry: () {
                setState(() {
                  _loadingLocation = true;
                  _locationError = null;
                });
                _getUserLocation();
              },
              onDirectionsTap: _openGoogleMaps,
            ),

            const Divider(height: 1),

            //  Map
            Expanded(
              child: DirectionsMap(
                hasLocation: r.hasLocation,
                initialTarget: initialTarget,
                markers: markers,
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  _mapController = controller;
                  if (_userPosition != null) _fitBounds();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}