import 'package:flutter/material.dart';
import '../../../search/presentation/screens/product_picker_screen.dart';

class RestaurantSearchBar extends StatelessWidget {
  const RestaurantSearchBar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProductPickerScreen(),
          ),
        ),
        child: AbsorbPointer(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for product...',
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF888888),
                size: 20,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}