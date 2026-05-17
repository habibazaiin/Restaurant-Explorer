import 'package:auth_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchResultHeader extends StatelessWidget {
  const SearchResultHeader({
    super.key, required this.productName,
    
  });

  final String productName;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryColor,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search,
                      color: Color(0xFF888888), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    productName,
                    style: const TextStyle(
                        fontSize: 15, color: Color(0xFF1A1A1A)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}