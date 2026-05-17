import 'package:flutter/material.dart';

class SearchDirectlyTile extends StatelessWidget {
  final String query;
  final VoidCallback onTap;

  const SearchDirectlyTile({super.key, required this.query, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.search, color: Color(0xFFF5A623)),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 15, color: Color(0xFF1A1A1A)),
          children: [
            const TextSpan(text: 'Search for '),
            TextSpan(
              text: '"$query"',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
