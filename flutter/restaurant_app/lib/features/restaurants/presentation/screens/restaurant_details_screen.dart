import 'package:auth_app/features/restaurants/presentation/cubit/product/product_cubit.dart';
import 'package:auth_app/features/restaurants/presentation/cubit/product/product_state.dart';
import 'package:auth_app/features/restaurants/presentation/widgets/error_state.dart';
import 'package:auth_app/core/widgets/loading_state.dart';
import 'package:auth_app/features/restaurants/presentation/widgets/product_section.dart';
import 'package:auth_app/features/restaurants/presentation/widgets/restaurant_details_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../restaurants/domain/entities/restaurant_entity.dart';
import '../widgets/product_card.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final RestaurantEntity restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductCubit>()..loadProducts(restaurant.id),
      child: _RestaurantDetailsView(restaurant: restaurant),
    );
  }
}

class _RestaurantDetailsView extends StatelessWidget {
  final RestaurantEntity restaurant;

  const _RestaurantDetailsView({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with cover image
          RestaurantDetailsScreenHeader(restaurant: restaurant),

          // Products section
          const ProductSection(),

          // Products grid
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: LoadingState(),
                  ),
                );
              }

              if (state is ProductError) {
                return SliverFillRemaining(
                  child: Center(
                    child: ErrorState(message: state.message,),
                  ),
                );
              }

              if (state is ProductLoaded) {
                if (state.products.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('No products available',
                          style: TextStyle(color: Color(0xFF888888))),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => ProductCard(product: state.products[i]),
                      childCount: state.products.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.2,
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox());
            },
          ),
        ],
      ),
    );
  }
}


