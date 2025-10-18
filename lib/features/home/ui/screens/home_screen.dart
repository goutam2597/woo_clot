import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/features/categories/ui/widgets/category_list.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/offers_card.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/text_n_button_widget.dart';
import 'package:flutter_woocommerce/features/products/ui/screens/product_details.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/product_card_horizontal.dart';
import 'package:flutter_woocommerce/common/widgets/dots_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/notifications/data/notifications_provider.dart';
import 'package:flutter_woocommerce/features/notifications/ui/screens/notifications_screen.dart';

import '../../../categories/data/models/categories_model.dart';
import '../../../products/data/models/products_model.dart';
import '../../data/models/promo_banner_model.dart';
import '../widgets/promo_banner_card.dart';

class HomeScreen extends StatefulWidget {
  final categories = dummyCategoryList;

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final products = dummyProductList;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: SvgPicture.asset(AssetsPath.logoSvg, width: 120),
        actions: [
          Consumer<NotificationsController>(
            builder: (context, notif, _) {
              final count = notif.unreadCount;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                    );
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_none, size: 20),
                      ),
                      if (count > 0)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              count > 9 ? '9+' : '$count',
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search any Product',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.camera_alt),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            TextNButtonWidget(text: 'Featured Categories', onTap: () {}),
            SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.none,
                physics: BouncingScrollPhysics(),
                itemCount: widget.categories.length,
                scrollDirection: Axis.horizontal,

                itemBuilder: (context, index) {
                  final categories = dummyCategoryList[index];
                  return CategoryList(categories: categories);
                },
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 220.0,
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() => _bannerIndex = index);
                },
              ),
              items: promoBanners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return PromoBannerCard(
                      discountText: banner.discountText,
                      productText: banner.productText,
                      descriptionText: banner.descriptionText,
                      buttonText: banner.buttonText,
                      imageUrl: banner.imageUrl,
                      onPressed: () {},
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            DotsIndicator(
              count: promoBanners.length,
              activeIndex: _bannerIndex,
            ),
            SizedBox(height: 16),
            OffersCard(
              onTap: () {},
              title: 'Deal of the day',
              subTitle: '22h 55m 20s remaining',
              bgColor: Colors.blue,
              icon: Icons.alarm,
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 464,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
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
                          builder: (context) =>
                              ProductDetails(products: product),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.asset(AssetsPath.offer, width: 120),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Special Offers',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'We make sure you get the\noffer you need at best prices',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            OffersCard(
              onTap: () {},
              title: 'Trending Products',
              subTitle: 'Last Date 29/11/25',
              bgColor: Colors.pink,
              icon: Icons.calendar_month,
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 464,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
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
                          builder: (context) =>
                              ProductDetails(products: product),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            OffersCard(
              onTap: () {},
              title: 'Clearance Sale',
              subTitle: 'Last Date 31/12/25',
              bgColor: Colors.cyan,
              icon: Icons.calendar_month,
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(AssetsPath.sale),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Sponsored:', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(AssetsPath.sale2),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Up to 50% Off',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios_sharp),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
