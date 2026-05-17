import 'package:auth_app/features/restaurants/presentation/cubit/restuarant/restaurant_cubit.dart';
import 'package:auth_app/features/restaurants/presentation/cubit/restuarant/restaurant_state.dart';
import 'package:auth_app/features/restaurants/presentation/widgets/error_state.dart';
import 'package:auth_app/core/widgets/loading_state.dart';
import 'package:auth_app/features/restaurants/presentation/widgets/restaurant_search_bar.dart';
import 'package:auth_app/features/restaurants/presentation/widgets/restaurant_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../widgets/restaurant_card.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RestaurantCubit>()..loadRestaurants(),
      child: const _RestaurantsView(),
    );
  }
}

class _RestaurantsView extends StatefulWidget {
  const _RestaurantsView();

  @override
  State<_RestaurantsView> createState() => _RestaurantsViewState();
}

class _RestaurantsViewState extends State<_RestaurantsView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar — tapping navigates to SearchScreen
            RestaurantSearchBar(searchController: _searchController),

            // Title
            const RestaurantTitle(),

            const SizedBox(height: 8),

            // List
            Expanded(
              child: BlocBuilder<RestaurantCubit, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoading) {
                    return const Center(
                      child: LoadingState(),
                    );
                  }

                  if (state is RestaurantError) {
                    return  Center(
                      child: ErrorState(message: state.message,),
                    );
                  }

                  if (state is RestaurantLoaded) {
                    if (state.filtered.isEmpty) {
                      return const Center(
                        child: Text(
                          'No restaurants found',
                          style: TextStyle(color: Color(0xFF888888)),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      color: const Color(0xFFF5A623),
                      onRefresh: context
                          .read<RestaurantCubit>()
                          .loadRestaurants,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: state.filtered.length,
                        itemBuilder: (_, i) =>
                            RestaurantCard(restaurant: state.filtered[i]),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


