import 'package:auth_app/core/utils/product_filter.dart';
import 'package:auth_app/features/restaurants/presentation/cubit/product/product_cubit.dart';
import 'package:auth_app/features/restaurants/presentation/cubit/product/product_state.dart';
import 'package:auth_app/features/search/presentation/screens/search_results_screen.dart';
import 'package:auth_app/features/search/presentation/widgets/product_search_header.dart';
import 'package:auth_app/features/search/presentation/widgets/search_directly_section.dart';
import 'package:auth_app/features/search/presentation/widgets/search_directly_tile.dart';
import 'package:auth_app/features/search/presentation/widgets/product_suggestions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';

class ProductPickerScreen extends StatelessWidget {
  const ProductPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductCubit>()..loadProducts(1),
      child: const _ProductPickerView(),
    );
  }
}

class _ProductPickerView extends StatefulWidget {
  const _ProductPickerView();

  @override
  State<_ProductPickerView> createState() => _ProductPickerViewState();
}

class _ProductPickerViewState extends State<_ProductPickerView> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToResults(BuildContext context, String productName) {
    if (productName.trim().isEmpty) return;

    FocusScope.of(context).unfocus();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(productName: productName.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProductSearchHeader(
              controller: _searchController,
              query: _query,
              onChanged: (val) {
                setState(() => _query = val);
              },
              onSubmitted: (val) {
                _goToResults(context, val);
              },
              onBack: () => Navigator.pop(context),
              onClear: () {
                setState(() {
                  _searchController.clear();
                  _query = '';
                });
              },
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFF5A623),
                      ),
                    );
                  }

                  if (state is ProductLoaded) {
                    final filtered = filterProducts(state.products, _query);

                    if (filtered.isEmpty) {
                      return SearchDirectlySection(
                        query: _query,
                        onSearchTap: () => _goToResults(context, _query),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_query.isNotEmpty) ...[
                          SearchDirectlyTile(
                            query: _query,
                            onTap: () => _goToResults(context, _query),
                          ),
                          const Divider(height: 1),
                        ],
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
                          child: Text(
                            'Suggested Products',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF888888),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ProductSuggestionsList(
                            products: filtered,
                            onTap: (product) => _goToResults(
                              context,
                              product.name,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return SearchDirectlySection(
                    query: _query,
                    onSearchTap: () => _goToResults(context, _query),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
