import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/features/home/data/bottom_nav_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/common/widgets/dots_indicator.dart';
import 'package:flutter_woocommerce/features/home/data/models/promo_banner_model.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/promo_banner_card.dart';

class PromoBannerCarousel extends StatelessWidget {
  final dynamic Function(int, CarouselPageChangedReason) onPageChanged;
  final int activeIndex;
  const PromoBannerCarousel({
    super.key,
    required this.onPageChanged,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 220.0,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: onPageChanged,
          ),
          itemCount: promoBanners.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final banner = promoBanners[index];
            return PromoBannerCard(
              discountText: banner.discountText,
              productText: banner.productText,
              descriptionText: banner.descriptionText,
              buttonText: banner.buttonText,
              imageUrl: banner.imageUrl,
              onPressed: () {
                // Jump to Shop tab (index 1) on BottomNav
                context.read<BottomNavController>().goTo(1);
              },
            );
          },
        ),
        const SizedBox(height: 8),
        DotsIndicator(count: promoBanners.length, activeIndex: activeIndex),
      ],
    );
  }
}
