import 'package:flutter/material.dart';

class ProductSearchHeader extends StatelessWidget {
  const ProductSearchHeader({
    super.key,
    required this.controller,
    required this.query,
    required this.onChanged,
    required this.onSubmitted,
    required this.onBack,
    required this.onClear,
  });

  final TextEditingController controller;
  final String query;

  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  final VoidCallback onBack;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5A623),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: 'Search for product...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF888888),
                  size: 20,
                ),
                suffixIcon: query.isNotEmpty
                    ? GestureDetector(
                        onTap: onClear,
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
        ],
      ),
    );
  }
}