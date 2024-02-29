import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/api_service.dart';

class ShoeListingViewModel extends ChangeNotifier {
  final ApiService _apiService = GetIt.I.get<ApiService>();

  Future<void> toggleFavorite(shoe) async {
    shoe.isFavorite = !shoe.isFavorite;
    await _apiService.setUserFavorite(shoe.id);
    notifyListeners();
  }
}