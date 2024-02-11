import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../services/api_service.dart';
import '../models/shoe_search_model.dart';

class SearchViewModel {
  final ApiService _apiService = GetIt.instance<ApiService>();
  final String sasToken = dotenv.env['AZURE_SAS_TOKEN']!;

  List<ShoeSearchModel> shoes = [];
  List<String?> suggestions = [];

  Future<void> searchShoes(String query) async {
    try {
      shoes = await _apiService.searchShoes(query);
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
}