import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/filter_widget.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/search_with_toolbar.dart';
import 'package:flutter_woocommerce/features/products/providers/shop_search_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/sorting_widget.dart';

import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/features/home/ui/widgets/notification_action.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/products/ui/screens/product_details.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/product_card_grid.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  Set<String> _selectedCategories = <String>{};
  late double _minPrice;
  late double _maxPrice;
  late RangeValues _priceRange;
  SortOption _sort = SortOption.relevance;

  @override
  void initState() {
    super.initState();
    final prices =
        dummyProductList
            .map((e) => _parsePrice(e.price))
            .whereType<double>()
            .toList()
          ..sort();
    _minPrice = prices.isNotEmpty ? prices.first : 0.0;
    _maxPrice = prices.isNotEmpty ? prices.last : 1000.0;
    _priceRange = RangeValues(_minPrice, _maxPrice);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  double? _parsePrice(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned);
  }

  double _parseRating(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  List<ProductsModel> get _filteredProducts {
    Iterable<ProductsModel> list = dummyProductList;

    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where(
        (p) =>
            p.title.toLowerCase().contains(q) ||
            p.shortDetails.toLowerCase().contains(q) ||
            p.description.toLowerCase().contains(q) ||
            p.category.title.toLowerCase().contains(q),
      );
    }

    if (_selectedCategories.isNotEmpty) {
      list = list.where((p) => _selectedCategories.contains(p.category.title));
    }

    list = list.where((p) {
      final price = _parsePrice(p.price) ?? 0.0;
      return price >= _priceRange.start && price <= _priceRange.end;
    });

    final result = list.toList();

    switch (_sort) {
      case SortOption.relevance:
        break;
      case SortOption.priceLowHigh:
        result.sort(
          (a, b) => (_parsePrice(a.price) ?? 0).compareTo(
            (_parsePrice(b.price) ?? 0),
          ),
        );
        break;
      case SortOption.priceHighLow:
        result.sort(
          (a, b) => (_parsePrice(b.price) ?? 0).compareTo(
            (_parsePrice(a.price) ?? 0),
          ),
        );
        break;
      case SortOption.ratingHighLow:
        result.sort(
          (a, b) => _parseRating(b.rating).compareTo(_parseRating(a.rating)),
        );
        break;
      case SortOption.titleAZ:
        result.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case SortOption.titleZA:
        result.sort(
          (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()),
        );
        break;
    }

    return result;
  }

  Future<void> _openSortSheet() async {
    final chosen = await showModalBottomSheet<SortOption>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SortSheet(current: _sort),
    );
    if (chosen != null && chosen != _sort) {
      setState(() => _sort = chosen);
    }
  }

  Future<void> _openFilterSheet() async {
    final categories =
        dummyProductList.map((e) => e.category.title).toSet().toList()..sort();

    final result = await showModalBottomSheet<FilterResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => FilterSheet(
        categories: categories,
        selected: _selectedCategories,
        currentRange: _priceRange,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
      ),
    );

    if (result == null) return;

    if (result.reset) {
      setState(() {
        _selectedCategories.clear();
        _priceRange = RangeValues(_minPrice, _maxPrice);
      });
    } else {
      setState(() {
        _selectedCategories = result.selected;
        _priceRange = result.range;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sync with global shop search query (from Home, etc.)
    final shopSearch = context.watch<ShopSearchProvider>();
    if (_searchController.text != shopSearch.query) {
      _searchController.text = shopSearch.query;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchController.text.length),
      );
      _query = shopSearch.query;
    }

    final products = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: SvgPicture.asset(AssetsPath.logoSvg, width: 120),
        actions: const [NotificationAction()],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: SearchAndToolbar(
            controller: _searchController,
            query: _query,
            itemCount: products.length,
            onQueryChanged: (v) {
              final trimmed = v.trim();
              setState(() => _query = trimmed);
              context.read<ShopSearchProvider>().setQuery(trimmed);
            },
            onClearQuery: () {
              _searchController.clear();
              setState(() => _query = '');
              context.read<ShopSearchProvider>().clear();
            },
            onTapSort: _openSortSheet,
            onTapFilter: _openFilterSheet,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCardGrid(
              product: products[index],
              onTap: () {
                // Clear shop search when navigating away
                context.read<ShopSearchProvider>().clear();
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
      ),
    );
  }
}
