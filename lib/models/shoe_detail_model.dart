class ShoeDetailModel {
  final String id;
  final String model;
  final String brand;
  final double newPrice;
  final double oldPrice;
  final List<String> sizes;
  final List<String> availableSizes;
  final String provider;
  final String url;
  final List<String> images;
  bool isFavorite;

  ShoeDetailModel({
    required this.id,
    required this.model,
    required this.brand,
    required this.newPrice,
    required this.oldPrice,
    required this.sizes,
    required this.availableSizes,
    required this.provider,
    required this.url,
    required this.images,
    required this.isFavorite,
  });

  factory ShoeDetailModel.fromJson(Map<String, dynamic> json) {
    return ShoeDetailModel(
      id: json['id'] ?? '',
      model: json['model'] ?? '',
      brand: json['brand'] ?? '',
      newPrice: json['newPrice'] ?? 0.0,
      oldPrice: json['oldPrice'] ?? 0.0,
      sizes: (json['sizes'] as List<dynamic>?)?.cast<String>() ?? [],
      availableSizes: (json['availableSizes'] as List<dynamic>?)?.cast<String>() ?? [],
      provider: json['provider'] ?? '',
      url: json['url'] ?? '',
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      isFavorite: json['favorite'] ?? false,
    );
  }
}