import 'package:flutter/material.dart';

class SearchBarHeader extends StatelessWidget {
  const SearchBarHeader({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onChanged,
  });

  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5A623),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: TextField(
        controller: controller,
        onSubmitted: (_) => onSearch(),
        onChanged: (_) => onChanged(),
        decoration: InputDecoration(
          hintText: 'Search for product...',
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF888888),
            size: 20,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.clear();
                    onChanged();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFF888888),
                    size: 18,
                  ),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}