import 'package:auth_app/core/widgets/loading_state.dart';
import 'package:auth_app/features/search/presentation/widgets/restaurant_options_bottom_sheet.dart';
import 'package:auth_app/features/search/presentation/widgets/search_bar_header.dart';
import 'package:auth_app/features/search/presentation/widgets/search_empty_widget.dart';
import 'package:auth_app/features/search/presentation/widgets/search_error_widget.dart';
import 'package:auth_app/features/search/presentation/widgets/search_initial_widget.dart';
import 'package:auth_app/features/search/presentation/widgets/search_map_widget.dart';
import 'package:auth_app/features/search/presentation/widgets/search_result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/view_toggle_buttons.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchCubit>(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _searchController.text.trim();

    if (query.isNotEmpty) {
      context.read<SearchCubit>().search(query);

      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarHeader(
              controller: _searchController,
              onSearch: _onSearch,
              onChanged: () {
                setState(() {});
              },
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const SearchInitialWidget();
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: LoadingState(),
                    );
                  }

                  if (state is SearchError) {
                    return SearchErrorWidget(
                      message: state.message,
                    );
                  }

                  if (state is SearchEmpty) {
                    return SearchEmptyWidget(
                      query: state.query,
                    );
                  }

                  if (state is SearchLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16,
                            14,
                            16,
                            10,
                          ),
                          child: Row(
                            children: [
                              ViewToggleButtons(
                                isListMode: state.isListMode,
                                onListTap: state.isListMode
                                    ? () {}
                                    : () {
                                        context
                                            .read<SearchCubit>()
                                            .switchToList();
                                      },
                                onMapTap: state.isListMode
                                    ? () {
                                        context
                                            .read<SearchCubit>()
                                            .switchToMap();
                                      }
                                    : () {},
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: state.isListMode
                              ? SearchResultList(
                                  state: state,
                                  onRestaurantTap: (index) {
                                    showRestaurantOptionsBottomSheet(
                                      context,
                                      state.restaurants[index],
                                    );
                                  },
                                )
                              : SearchMapWidget(
                                  state: state,
                                  onMarkerTap: (index) {
                                    showRestaurantOptionsBottomSheet(
                                      context,
                                      state.mapRestaurants[index],
                                    );
                                  },
                                ),
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
