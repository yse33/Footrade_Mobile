import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../services/api_service.dart';
import '../models/shoe_search_model.dart';

class SearchViewModel {
  final ApiService _apiService = GetIt.instance<ApiService>();
  final String sasToken = dotenv.env['AZURE_SAS_TOKEN']!;

  List<ShoeSearchModel> _allShoes = [];
  List<ShoeSearchModel> shoes = [];
  List<String?> suggestions = [];
  int page = 0;
  int pageSize = 10;
  bool hasMore = true;

  Future<void> searchShoes(String query) async {
    try {
      _allShoes = await _apiService.searchShoes(query);
      shoes = _allShoes.skip(page * pageSize).take(pageSize).toList();
      hasMore = shoes.length < _allShoes.length;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> getSuggestions(String query) async {
    try {
      suggestions = await _apiService.getSuggestions(query);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> loadMore() async {
    page++;
    shoes.addAll(_allShoes.skip(page * pageSize).take(pageSize).toList());
    hasMore = shoes.length < _allShoes.length;
  }

  Future<void> clear() async {
    shoes = [];
    _allShoes = [];
    suggestions = [];
    page = 0;
    hasMore = true;
  }
}