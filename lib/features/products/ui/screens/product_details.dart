import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_woocommerce/common/widgets/header_text.dart';
import 'package:flutter_woocommerce/common/widgets/rating_star_widget.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:flutter_woocommerce/features/wishlist/data/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/checkout_screen.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/product_card_grid.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/variation_dropdown.dart';

class ProductDetails extends StatefulWidget {
  final ProductsModel products;
  const ProductDetails({super.key, required this.products});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _selectedStorageIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final sliders = widget.products.sliderImages;
    final List<String> colorOptions = widget.products.variations
        .map((v) => v.color)
        .whereType<String>()
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
    final List<String> storageOptions = widget.products.variations
        .map((v) => v.storage)
        .whereType<String>()
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
    final List<String> sizeOptions = widget.products.variations
        .map((v) => v.size)
        .whereType<String>()
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    if (_selectedColorIndex >= colorOptions.length) _selectedColorIndex = 0;
    if (_selectedSizeIndex >= sizeOptions.length) _selectedSizeIndex = 0;
    if (_selectedStorageIndex >= storageOptions.length) {
      _selectedStorageIndex = 0;
    }

    return Scaffold(
      appBar: CustomAppBar(
        rightIcon: Icons.shopping_cart_outlined,
        centerTitle: false,
        middle: TextField(
          controller: _searchController,
          onChanged: (_) {},
          decoration: InputDecoration(
            hintText: 'Search product',
            isDense: true,
            prefixIcon: const Icon(Icons.search, size: 20),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            filled: true,
            fillColor: const Color(0xFFF2F2F2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {},
                ),
                items: sliders.map((banner) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(banner.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    if (sizeOptions.isNotEmpty)
                      Expanded(
                        child: VariationDropdown(
                          title: 'Size',
                          values: sizeOptions,
                          selectedIndex: _selectedSizeIndex,
                          onChanged: (i) =>
                              setState(() => _selectedSizeIndex = i),
                        ),
                      ),
                    Expanded(
                      child: VariationDropdown(
                        title: 'Color',
                        values: colorOptions,
                        selectedIndex: _selectedColorIndex,
                        onChanged: (i) =>
                            setState(() => _selectedColorIndex = i),
                        showColorDot: true,
                      ),
                    ),
                    if (storageOptions.isNotEmpty)
                      Expanded(
                        child: VariationDropdown(
                          title: 'Storage',
                          values: storageOptions,
                          selectedIndex: _selectedStorageIndex,
                          onChanged: (i) =>
                              setState(() => _selectedStorageIndex = i),
                        ),
                      ),
                    Builder(
                      builder: (context) {
                        final wish = context.watch<WishlistController>();
                        final isWished = wish.contains(widget.products);
                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            context.read<WishlistController>().toggle(
                              widget.products,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isWished
                                      ? 'Removed from wishlist'
                                      : 'Added to wishlist',
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isWished
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.products.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '\$${widget.products.discount}  ',
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w700,
                            ),
                            children: [
                              TextSpan(
                                text: '\$${widget.products.price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        StarRating(
                          rating: double.parse(widget.products.rating),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${widget.products.review}) Reviews',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.products.shortDetails,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Tabs: Description and Reviews
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black54,
                            indicatorColor: AppColors.themeColor,
                            onTap: (i) => setState(() {}),
                            tabs: const [
                              Tab(text: 'Description'),
                              Tab(text: 'Reviews'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Builder(
                            builder: (ctx) {
                              final controller = DefaultTabController.of(ctx);
                              final index = controller.index;
                              // Rebuild when tab changes
                              controller.addListener(() {
                                if (mounted) setState(() {});
                              });
                              if (index == 0) {
                                return Text(
                                  widget.products.description.isNotEmpty
                                      ? widget.products.description
                                      : 'No description available for this product.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                );
                              } else {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.products.reviews.length,
                                  separatorBuilder: (_, _) =>
                                      const Divider(height: 1),
                                  itemBuilder: (context, index) {
                                    final review =
                                        widget.products.reviews[index];
                                    return ListTile(
                                      leading:
                                          review.userImage != null &&
                                              review.userImage!.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundImage: AssetImage(
                                                review.userImage!,
                                              ),
                                            )
                                          : const CircleAvatar(
                                              child: Icon(Icons.person),
                                            ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            review.username ?? 'User',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            review.date ?? '',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 4),
                                          StarRating(
                                            rating:
                                                double.tryParse(
                                                  review.rating ?? '0',
                                                ) ??
                                                0,
                                            size: 18,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            review.comment ?? '',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: HeaderText(text: 'Related Products', fontSize: 18),
              ),

              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: dummyProductList.length,
                itemBuilder: (context, index) {
                  final products = dummyProductList;
                  return ProductCardGrid(
                    product: products[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(products: products[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
          decoration: BoxDecoration(color: Colors.white),
          child: Builder(
            builder: (context) {
              final double unitPrice =
                  double.tryParse((widget.products.discount).toString()) ?? 0.0;
              final double total = unitPrice * _quantity;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              splashRadius: 18,
                              onPressed: () {
                                setState(() {
                                  if (_quantity > 1) _quantity--;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              splashRadius: 18,
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Total: ',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: '\$${total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              final double unitPrice =
                                  double.tryParse(widget.products.discount) ??
                                  0.0;
                              final double oldPrice =
                                  double.tryParse(widget.products.price) ?? 0.0;
                              double discountEach = oldPrice - unitPrice;
                              if (discountEach < 0) discountEach = 0.0;
                              final double subtotal = unitPrice * _quantity;
                              final double discountTotal =
                                  discountEach * _quantity;

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CheckoutScreen(
                                    totalQuantity: _quantity,
                                    subtotal: subtotal,
                                    discount: discountTotal,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.themeColor,
                              elevation: 0,
                            ),
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          final cart = context.read<CartController>();
                          final color = (colorOptions.isNotEmpty)
                              ? colorOptions[_selectedColorIndex]
                              : null;
                          final size = (sizeOptions.isNotEmpty)
                              ? sizeOptions[_selectedSizeIndex]
                              : null;
                          final storage = (storageOptions.isNotEmpty)
                              ? storageOptions[_selectedStorageIndex]
                              : null;
                          cart.add(
                            widget.products,
                            quantity: _quantity,
                            color: color,
                            size: size,
                            storage: storage,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')),
                          );
                        },
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
