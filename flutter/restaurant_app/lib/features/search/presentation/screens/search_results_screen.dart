import 'package:auth_app/core/widgets/loading_state.dart';
import 'package:auth_app/features/restaurants/presentation/screens/restaurant_details_screen.dart';
import 'package:auth_app/features/restaurants/presentation/widgets/error_state.dart';
import 'package:auth_app/features/search/presentation/screens/direction_screen.dart';
import 'package:auth_app/features/search/presentation/widgets/search_result_header.dart';
import 'package:auth_app/features/search/presentation/widgets/search_results_list.dart';
import 'package:auth_app/features/search/presentation/widgets/search_results_map_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/di/injection_container.dart';
import '../../../restaurants/domain/entities/restaurant_entity.dart';
import '../../domain/entities/search_restaurant_entity.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/view_toggle_buttons.dart';

class SearchResultsScreen extends StatelessWidget {
  final String productName;

  const SearchResultsScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchCubit>()..search(productName),
      child: _SearchResultsView(productName: productName),
    );
  }
}

class _SearchResultsView extends StatefulWidget {
  final String productName;
  const _SearchResultsView({required this.productName});

  @override
  State<_SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<_SearchResultsView> {
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  /// SearchRestaurantEntity → RestaurantEntity للـ details screen
  RestaurantEntity _toRestaurantEntity(SearchRestaurantEntity r) {
    return RestaurantEntity(
      id: r.id,
      name: r.name,
      description: r.description,
      coverImageUrl: r.coverImageUrl,
      address: r.address,
      type: r.type,
      cuisineType: r.cuisineType,
      openingTime: r.openingTime,
      closingTime: r.closingTime,
      openNow: r.openNow,
    );
  }

  void _openRestaurantDetails(BuildContext context, SearchRestaurantEntity r) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            RestaurantDetailsScreen(restaurant: _toRestaurantEntity(r)),
      ),
    );
  }

  void _openDirections(BuildContext context, SearchRestaurantEntity r) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DirectionsScreen(restaurant: r)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            SearchResultHeader(productName: widget.productName),

            // Content
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: LoadingState(),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: ErrorState(message: state.message),
                    );
                  }

                  if (state is SearchEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off,
                              size: 64, color: Color(0xFFCCCCCC)),
                          const SizedBox(height: 16),
                          Text(
                            'No restaurants found\nfor "${state.query}"',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xFF999999), fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SearchLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                          child: Row(
                            children: [
                              ViewToggleButtons(
                                isListMode: state.isListMode,
                                onListTap: state.isListMode
                                    ? () {}
                                    : () => context
                                        .read<SearchCubit>()
                                        .switchToList(),
                                onMapTap: state.isListMode
                                    ? () => context
                                        .read<SearchCubit>()
                                        .switchToMap()
                                    : () {},
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: state.isListMode
                              ? SearchResultsList(
                                  restaurants: state.restaurants,
                                  onTap: (restaurant) {
                                    _openRestaurantDetails(
                                      context,
                                      restaurant,
                                    );
                                  },
                                ) // card → RestaurantDetails
                              : SearchResultsMapList(
                                  restaurants: state.mapRestaurants,
                                  onTap: (restaurant) {
                                    _openDirections(context, restaurant);
                                  },
                                ), // card → Directions
                        ),
                      ],
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
