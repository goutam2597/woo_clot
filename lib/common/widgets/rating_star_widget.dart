import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final Color color;
  final double size;

  const StarRating({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.color = Colors.amber,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        final starIndex = index + 1;
        if (rating >= starIndex) {
          return Icon(Icons.star, color: color, size: size);
        } else if (rating >= starIndex - 0.5) {
          return Icon(Icons.star_half, color: color, size: size);
        } else {
          return Icon(Icons.star_border, color: color, size: size);
        }
      }),
    );
  }
}
