import 'package:flutter/material.dart';

class SearchEmptyLocationsWidget
    extends StatelessWidget {
  const SearchEmptyLocationsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            'No location data available\nfor these restaurants',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }
}