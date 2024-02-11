import 'package:flutter/material.dart';
import 'package:footrade_mvvm/view_models/search_view_model.dart';

import '../constants/app_icons.dart';
import '../constants/app_dimensions.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchViewModel viewModel = SearchViewModel();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(AppIcons.clear),
        onPressed: () {
          query = '';
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (viewModel.shoes.isEmpty) {
          return Center(child: Text('No results found for: $query'));
        } else {
          return ListView.builder(
            itemCount: viewModel.shoes.length,
            itemBuilder: (context, index) {
              final shoe = viewModel.shoes[index];
              return Card(
                elevation: 4,
                margin: AppDimensions.standardMargin,
                child: InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        '${shoe.image}?${viewModel.sasToken}',
                        fit: BoxFit.fitWidth,
                        height: 300,
                      ),
                      Padding(
                        padding: AppDimensions.standardPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shoe.model,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              shoe.brand,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (viewModel.suggestions.isEmpty) {
          return Center(child: Text('No suggestions found for: $query'));
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