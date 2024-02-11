import 'package:flutter/material.dart';
import 'package:footrade_mvvm/view_models/search_view_model.dart';

import '../components/custom_shoe_search_listing_widget.dart';
import '../constants/app_icons.dart';
import '../constants/app_strings.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchViewModel viewModel = SearchViewModel();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(AppIcons.clear),
        onPressed: () {
          query = '';
          viewModel.clear();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.arrowBack),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<void>(
      future: viewModel.searchShoes(query),
      builder: (context, snapshot) {
        if (query.isEmpty) {
          return const Center(child: Text(AppStrings.searchEmpty));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(AppStrings.searchFailed + query));
        } else if (viewModel.shoes.isEmpty) {
          return Center(child: Text(AppStrings.searchResultEmpty + query));
        } else {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  CustomShoeSearchListingWidget(
                    shoes: viewModel.shoes,
                    sasToken: viewModel.sasToken,
                  ),
                  Visibility(
                    visible: viewModel.hasMore,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.loadMore();
                        setState(() {});
                      },
                      child: const Text(AppStrings.loadMore),
                    ),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<void>(
      future: viewModel.getSuggestions(query),
      builder: (context, snapshot) {
        if (query.isEmpty) {
          return const Center(child: Text(AppStrings.suggestionsEmpty));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(AppStrings.suggestionsFailed + query));
        } else if (viewModel.suggestions.isEmpty) {
          return Center(child: Text(AppStrings.suggestionsResultEmpty + query));
        } else {
          return ListView.builder(
            itemCount: viewModel.suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = viewModel.suggestions[index];
              return ListTile(
                title: Text(suggestion.toString()),
                onTap: () {
                  query = suggestion.toString();
                  showResults(context);
                },
              );
            },
          );
        }
      },
    );
  }
}