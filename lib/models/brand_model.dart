class BrandModel {
  final String brand;
  final String image;
  bool isSelected = false;

  BrandModel({required this.brand, required this.image});

  String get name => brand.toString().split('.').last;
}