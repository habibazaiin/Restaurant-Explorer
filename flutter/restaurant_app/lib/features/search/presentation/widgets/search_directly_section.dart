import 'package:flutter/material.dart';

import 'search_directly_tile.dart';

class SearchDirectlySection extends StatelessWidget {
  const SearchDirectlySection({
    super.key,
    required this.query,
    required this.onSearchTap,
  });

  final String query;
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (query.isNotEmpty)
          SearchDirectlyTile(
            query: query,
            onTap: onSearchTap,
          )
        else
          const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.search,
                    size: 64,
                    color: Color(0xFFCCCCCC),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Type a product name\nto search restaurants',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}