import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../models/shoe_preference_model.dart';
import '../services/api_service.dart';

class ShoePreferenceViewModel extends ChangeNotifier {
  final String sasToken = dotenv.env['AZURE_SAS_TOKEN']!;
  final ApiService _apiService = GetIt.I<ApiService>();
  List<ShoePreferenceModel> shoes = [];
  bool isLoading = false;
  bool hasError = false;
  bool isLastPage = false;
  int currentPage = 1;
  final int pageSize = 20;

  Future<void> fetchShoes() async {
    try {
      isLoading = true;
      notifyListeners();

      shoes = await _apiService.getShoePreferences(page:currentPage, pageSize:pageSize);

      isLastPage = shoes.length < pageSize;

      hasError = false;
    } on Exception catch (e) {
      hasError = true;
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> changePage(int page) async {
    currentPage = page;
    await fetchShoes();
  }

  void onItemClick(String id) async {
    // TODO: Implement onItemClick
  }
}