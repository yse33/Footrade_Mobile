import 'package:flutter/material.dart';

import '../models/brand_model.dart';
import '../models/size_model.dart';
import '../services/api_service.dart';
import '../utils/brand_enum.dart';

class PreferenceViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<BrandModel> brands = [];
  final List<SizeModel> sizes = [
    SizeModel(size: "EU 36"), SizeModel(size: "EU 36.5"), SizeModel(size: "EU 37"), SizeModel(size: "EU 38"),
    SizeModel(size: "EU 38.5"), SizeModel(size: "EU 39"), SizeModel(size: "EU 40"), SizeModel(size: "EU 40.5"),
    SizeModel(size: "EU 41"), SizeModel(size: "EU 42"), SizeModel(size: "EU 42.5"), SizeModel(size: "EU 43"),
    SizeModel(size: "EU 44"), SizeModel(size: "EU 44.5"), SizeModel(size: "EU 45"), SizeModel(size: "EU 45.5"),
    SizeModel(size: "EU 46"), SizeModel(size: "EU 47"), SizeModel(size: "EU 47.5"), SizeModel(size: "EU 48"),
    SizeModel(size: "EU 48.5"), SizeModel(size: "EU 49"), SizeModel(size: "EU 49.5"), SizeModel(size: "EU 50"),
    SizeModel(size: "EU 50.5"), SizeModel(size: "EU 51.5"), SizeModel(size: "EU 52.5")
  ];

  PreferenceViewModel() {
    initBrands();
  }

  void initBrands() {
    for (int i = 0; i < 5; i++) {
      brands.add(BrandModel(
        brand: BrandEnum.values[i],
        image: 'assets/images/brand$i.png',
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

  void savePreferences() async {
    // TODO: check if brands and sizes are selected
    await apiService.saveUserPreference(
      brands.where((brand) => brand.isSelected).map((brand) => BrandEnum.values.indexOf(brand.brand)).toList(),
      sizes.where((size) => size.isSelected).map((size) => size.size).toList(),
    );
  }
}