class DetailsSliderModel {
  final String imageUrl;

  DetailsSliderModel({required this.imageUrl});

  factory DetailsSliderModel.fromJson(Map<String, dynamic> json) {
    return DetailsSliderModel(imageUrl: json['imageUrl'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'imageUrl': imageUrl};
  }
}
