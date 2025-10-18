import 'package:flutter_woocommerce/app/assets_path.dart';

class CategoryListModel {
  final String images;
  final String title;

  CategoryListModel({required this.images, required this.title});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return CategoryListModel(
      images: json['images'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'images': images, 'title': title};
  }
}

final List<CategoryListModel> dummyCategoryList = [
  CategoryListModel(images: AssetsPath.smartWatch, title: 'Watches'),
  CategoryListModel(images: AssetsPath.bluetoothHeadset, title: 'Headphones'),
  CategoryListModel(images: AssetsPath.mobile, title: 'Mobile'),
  CategoryListModel(images: AssetsPath.powerBankBlack, title: 'Accessories'),
  CategoryListModel(images: AssetsPath.portableSpeaker, title: 'Sound'),
  CategoryListModel(images: AssetsPath.laptop, title: 'Computers'),
];
