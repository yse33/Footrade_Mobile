import 'package:flutter/material.dart';
import 'package:footrade_mvvm/view_models/search_view_model.dart';

import '../components/custom_shoe_search_listing_widget.dart';
import '../constants/app_icons.dart';

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
          return Column(
            children: [
              CustomShoeSearchListingWidget(
                shoes: viewModel.shoes,
                sasToken: viewModel.sasToken,
              ),
            ],
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