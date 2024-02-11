class ShoePreferenceModel {
  final String id;
  final String model;
  final String brand;
  final double newPrice;
  final double oldPrice;
  final String image;
  bool isFavorite;

  ShoePreferenceModel({
    required this.id,
    required this.model,
    required this.brand,
    required this.newPrice,
    required this.oldPrice,
    required this.image,
    required this.isFavorite,
  });

  factory ShoePreferenceModel.fromJson(Map<String, dynamic> json) {
    return ShoePreferenceModel(
      id: json['id'] ?? '',
      model: json['model'] ?? '',
      brand: json['brand'] ?? '',
      newPrice: json['newPrice'] ?? 0.0,
      oldPrice: json['oldPrice'] ?? 0.0,
      image: json['initialImage'] ?? '',
      isFavorite: json['favorite'] ?? false,
    );
  }
}