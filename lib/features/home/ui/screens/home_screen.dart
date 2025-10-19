import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/offer_banner.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/promo_banner.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/search_bar_widget.dart';
import 'package:flutter_woocommerce/features/categories/ui/screens/categories_screen.dart';
import 'package:flutter_woocommerce/features/categories/ui/widgets/category_list.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/notification_action.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/offers_card.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/sponsor_card.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/text_n_button_widget.dart';
import 'package:flutter_woocommerce/features/products/ui/screens/product_details.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/product_card_horizontal.dart';
import '../../../categories/data/models/categories_model.dart';
import '../../../products/data/models/products_model.dart';

class HomeScreen extends StatefulWidget {
  final categories = dummyCategoryList;
  final ValueChanged<int>? onRequestTabChange;

  HomeScreen({super.key, this.onRequestTabChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bannerIndex = 0;
  final products = dummyProductList;

  void _onBannerPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() => _bannerIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: SvgPicture.asset(AssetsPath.logoSvg, width: 120),
        actions: [
          NotificationAction(onRequestTabChange: widget.onRequestTabChange),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBarWidget(),
            // Featured Categories Section
            TextNButtonWidget(
              text: 'Featured Categories',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()),
                );
              },
            ),
            const SizedBox(height: 12),
            _categoryList(widget.categories),
            // Promo Banner Carousel Section
            PromoBannerCarousel(
              onPageChanged: _onBannerPageChanged,
              activeIndex: _bannerIndex,
            ),
            const SizedBox(height: 16),

            // Deal of the Day Section
            OffersCard(
              onTap: () => widget.onRequestTabChange?.call(1),
              title: 'Deal of the day',
              subTitle: '22h 55m 20s remaining',
              bgColor: Colors.blue,
              icon: Icons.alarm,
            ),
            const SizedBox(height: 12),
            _horizontalProductList(products),

            const SizedBox(height: 16),
            // Special Offers Banner
            const SpecialOffersBanner(),

            const SizedBox(height: 16),
            // Trending Products Section
            OffersCard(
              onTap: () => widget.onRequestTabChange?.call(1),
              title: 'Trending Products',
              subTitle: 'Last Date 29/11/25',
              bgColor: Colors.pink,
              icon: Icons.calendar_month,
            ),
            const SizedBox(height: 16),
            _horizontalProductList(products),

            const SizedBox(height: 16),
            // Clearance Sale Section
            OffersCard(
              onTap: () => widget.onRequestTabChange?.call(1),
              title: 'Clearance Sale',
              subTitle: 'Last Date 31/12/25',
              bgColor: Colors.cyan,
              icon: Icons.calendar_month,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(AssetsPath.sale),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SponsoredCard(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

SizedBox _categoryList(final List<dynamic> categories) {
  return SizedBox(
    height: 110,
    child: ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryList(categories: category);
      },
    ),
  );
}

SizedBox _horizontalProductList(final List<ProductsModel> products) {
  return SizedBox(
    height: 464,
    child: ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCardHorizontal(
          product: product,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(products: product),
              ),
            );
          },
        );
      },
    ),
  );
}
