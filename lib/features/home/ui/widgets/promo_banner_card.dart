import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';

class PromoBannerCard extends StatelessWidget {
  final String discountText;
  final String productText;
  final String descriptionText;
  final String buttonText;
  final String imageUrl;
  final VoidCallback? onPressed;

  const PromoBannerCard({
    super.key,
    required this.discountText,
    required this.productText,
    required this.descriptionText,
    required this.buttonText,
    required this.imageUrl,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  discountText,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Now in $productText',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  descriptionText,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 140,
                  child: InkWell(
                    onTap: onPressed,
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            buttonText,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            imageUrl,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 160,
              height: 160,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
