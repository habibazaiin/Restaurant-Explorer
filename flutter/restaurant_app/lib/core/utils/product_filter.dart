import 'package:auth_app/features/restaurants/domain/entities/product_entity.dart';

List<ProductEntity> filterProducts(
  List<ProductEntity> products,
  String query,
) {
  if (query.isEmpty) return products;

  return products
      .where((p) =>
          p.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
}