import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/common/widgets/header_text.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/checkout_screen.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/bottom_purchase_bar.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/product_card_grid.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/products_info_tabs.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/variation_row.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.products});

  final ProductsModel products;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _selectedStorageIndex = 0;
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
              _ProductCarousel(sliders: sliders),
              const SizedBox(height: 4),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: VariationsRow(
                  sizeOptions: sizeOptions,
                  colorOptions: colorOptions,
                  storageOptions: storageOptions,
                  selectedSizeIndex: _selectedSizeIndex,
                  selectedColorIndex: _selectedColorIndex,
                  selectedStorageIndex: _selectedStorageIndex,
                  onSelectSize: (i) => setState(() => _selectedSizeIndex = i),
                  onSelectColor: (i) => setState(() => _selectedColorIndex = i),
                  onSelectStorage: (i) =>
                      setState(() => _selectedStorageIndex = i),
                  products: widget.products,
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProductInfoAndTabs(products: widget.products),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: HeaderText(text: 'Related Products', fontSize: 18),
              ),
              const _RelatedProductsGrid(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomPurchaseBar(
          products: widget.products,
          quantity: _quantity,
          onDecrement: () {
            setState(() {
              if (_quantity > 1) _quantity--;
            });
          },
          onIncrement: () => setState(() => _quantity++),
          onBuyNow: () {
            final double unitPrice =
                double.tryParse(widget.products.discount) ?? 0.0;
            final double oldPrice =
                double.tryParse(widget.products.price) ?? 0.0;
            double discountEach = oldPrice - unitPrice;
            if (discountEach < 0) discountEach = 0.0;
            final double subtotal = unitPrice * _quantity;
            final double discountTotal = discountEach * _quantity;

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
          onAddToCart: () {
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

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Added to cart')));
          },
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

class _ProductCarousel extends StatelessWidget {
  const _ProductCarousel({required this.sliders});
  final List<dynamic> sliders;

  String _resolveImagePath(dynamic banner) {
    if (banner is String) return banner;

    if (banner is Map) {
      final v = banner['imageUrl'] ?? banner['image'] ?? banner['path'];
      if (v is String) return v;
    }
    try {
      final v = (banner.imageUrl ?? banner.image ?? banner.path) as String?;
      if (v != null) return v;
    } catch (_) {}
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        viewportFraction: 1,
        onPageChanged: (index, reason) {},
      ),
      items: sliders.map((banner) {
        final path = _resolveImagePath(banner);
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(path),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class _RelatedProductsGrid extends StatelessWidget {
  const _RelatedProductsGrid();

  @override
  Widget build(BuildContext context) {
    final products = dummyProductList;

    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardGrid(
          product: products[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(products: products[index]),
              ),
            );
          },
        );
      },
    );
  }
}
