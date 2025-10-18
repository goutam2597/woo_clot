class ReviewsModel {
  final String? date;
  final String? username;
  final String? userImage;
  final String? comment;
  final String? rating;

  ReviewsModel({
    this.date,
    this.username,
    this.userImage,
    this.comment,
    this.rating,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      date: json['date'] ?? '',
      username: json['username'] ?? '',
      userImage: json['userImage'] ?? '',
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'username': username,
      'userImage': userImage,
      'comment': comment,
      'rating': rating,
    };
  }
}
