import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/brand_model.dart';
import '../models/size_model.dart';
import '../services/api_service.dart';
import '../constants/app_strings.dart';

class PreferenceViewModel extends ChangeNotifier {
  final ApiService _apiService = GetIt.I.get<ApiService>();

  List<BrandModel> brands = [];
  final List<SizeModel> sizes = [];

  PreferenceViewModel() {
    initBrands();
    initSizes();
  }

  void initBrands() {
    for (int i = 0; i < 5; i++) {
      brands.add(BrandModel(
        brand: AppStrings.brandNames[i],
        image: 'assets/images/${AppStrings.brandNames[i]}.png',
      ));
    }
  }

  void initSizes() {
    for (int i = 0; i < AppStrings.brandSizes.length; i++) {
      sizes.add(SizeModel(
        size: AppStrings.brandSizes[i],
      ));
    }
  }

  void toggleBrand(BrandModel brand) {
    brand.isSelected = !brand.isSelected;
    notifyListeners();
  }

  void toggleSize(SizeModel size) {
    size.isSelected = !size.isSelected;
    notifyListeners();
  }

  Future<void> savePreferences() async {
    if (brands.every((brand) => !brand.isSelected) || sizes.every((size) => !size.isSelected)) {
      throw Exception(AppStrings.preferenceFailed);
    }

    await _apiService.saveUserPreference(
      brands.where((brand) => brand.isSelected).map((brand) => brand.brand.toUpperCase()).toList(),
      sizes.where((size) => size.isSelected).map((size) => size.size).toList(),
    );
  }
}