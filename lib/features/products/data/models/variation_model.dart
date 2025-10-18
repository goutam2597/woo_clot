class VariationModel {
  final String? size;
  final String? color;
  final String? storage;

  VariationModel({this.size, this.color, this.storage});

  factory VariationModel.fromJson(Map<String, dynamic> json) {
    return VariationModel(
      size: json['size'] ?? '',
      color: json['color'] ?? '',
      storage: json['storage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'size': size, 'color': color, 'storage': storage};
  }
}
