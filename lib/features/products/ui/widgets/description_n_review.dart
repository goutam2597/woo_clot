import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/rating_star_widget.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';

class DescriptionOrReviews extends StatefulWidget {
  const DescriptionOrReviews({super.key, required this.products});
  final ProductsModel products;

  @override
  State<DescriptionOrReviews> createState() => _DescriptionOrReviewsState();
}

class _DescriptionOrReviewsState extends State<DescriptionOrReviews> {
  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    final index = controller.index;

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    if (index == 0) {
      return Text(
        widget.products.description.isNotEmpty
            ? widget.products.description
            : 'No description available for this product.',
        style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.products.reviews.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final review = widget.products.reviews[i];
        return ListTile(
          leading: (review.userImage != null && review.userImage!.isNotEmpty)
              ? CircleAvatar(backgroundImage: AssetImage(review.userImage!))
              : const CircleAvatar(child: Icon(Icons.person)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.username ?? 'User',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                review.date ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              StarRating(
                rating: double.tryParse(review.rating ?? '0') ?? 0,
                size: 18,
              ),
              const SizedBox(height: 6),
              Text(review.comment ?? '', style: const TextStyle(fontSize: 14)),
            ],
          ),
        );
      },
    );
  }
}
