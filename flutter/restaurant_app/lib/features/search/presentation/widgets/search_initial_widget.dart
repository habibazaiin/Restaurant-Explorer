import 'package:flutter/material.dart';

class SearchInitialWidget extends StatelessWidget {
  const SearchInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search,
              size: 64,
              color: Color(0xFFCCCCCC)),
          SizedBox(height: 16),
          Text(
            'Search for a product\nto find restaurants',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}