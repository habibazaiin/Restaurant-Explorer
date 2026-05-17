import 'package:auth_app/features/restaurants/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';



class ProductSuggestionsList extends StatelessWidget {
  const ProductSuggestionsList({
    super.key,
    required this.products,
    required this.onTap,
  });

  final List<ProductEntity> products;
  final Function(ProductEntity product) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, indent: 16),
      itemBuilder: (_, i) {
        final product = products[i];

        return ListTile(
          leading: const Icon(
            Icons.fastfood_outlined,
            color: Color(0xFFF5A623),
          ),
          title: Text(
            product.name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Color(0xFFAAAAAA),
          ),
          onTap: () => onTap(product),
        );
      },
    );
  }
}