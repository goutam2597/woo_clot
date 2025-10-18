import 'package:flutter_woocommerce/app/assets_path.dart';

class PromoBannerModel {
  final String discountText;
  final String productText;
  final String descriptionText;
  final String buttonText;
  final String imageUrl;

  PromoBannerModel({
    required this.discountText,
    required this.productText,
    required this.descriptionText,
    required this.buttonText,
    required this.imageUrl,
  });

  factory PromoBannerModel.fromJson(Map<String, dynamic> json) {
    return PromoBannerModel(
      discountText: json['discountText'] ?? '',
      productText: json['productText'] ?? '',
      descriptionText: json['descriptionText'] ?? '',
      buttonText: json['buttonText'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}

final List<PromoBannerModel> promoBanners = [
  PromoBannerModel(
    discountText: '50-40% OFF',
    productText: '(product)',
    descriptionText: 'All colours',
    buttonText: 'Shop Now',
    imageUrl: AssetsPath.slide1,
  ),
  PromoBannerModel(
    discountText: '30% OFF',
    productText: 'Shoes',
    descriptionText: 'Trendy styles',
    buttonText: 'Shop Now',
    imageUrl: AssetsPath.slide2,
  ),
  PromoBannerModel(
    discountText: '20% OFF',
    productText: 'Bags',
    descriptionText: 'New arrivals',
    buttonText: 'Shop Now',
    imageUrl: AssetsPath.slide3,
  ),
];
