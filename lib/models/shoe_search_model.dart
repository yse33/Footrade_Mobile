class ShoeSearchModel {
  final String id;
  final String model;
  final String brand;
  final String image;
  bool isFavorite;

  ShoeSearchModel({
    required this.id,
    required this.model,
    required this.brand,
    required this.image,
    required this.isFavorite,
  });

  factory ShoeSearchModel.fromJson(Map<String, dynamic> json) {
    return ShoeSearchModel(
      id: json['id'] ?? '',
      model: json['model'] ?? '',
      brand: json['brand'] ?? '',
      image: json['initialImage'] ?? '',
      isFavorite: json['favorite'] ?? false,
    );
  }
}