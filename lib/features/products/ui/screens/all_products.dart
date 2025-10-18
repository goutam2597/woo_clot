import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/products/ui/screens/product_details.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/product_card_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/notifications/data/notifications_provider.dart';
import 'package:flutter_woocommerce/features/notifications/ui/screens/notifications_screen.dart';

enum SortOption {
  relevance,
  priceLowHigh,
  priceHighLow,
  ratingHighLow,
  titleAZ,
  titleZA,
}

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // Filters
  Set<String> _selectedCategories = <String>{};
  late double _minPrice;
  late double _maxPrice;
  late RangeValues _priceRange;

  // Sort
  SortOption _sort = SortOption.relevance;

  @override
  void initState() {
    super.initState();
    // Initialize price range from data
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
        // Keep original order
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

  void _openSortSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'Sort by',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  _sortTile('Relevance', SortOption.relevance),
                  _sortTile('Price: Low to High', SortOption.priceLowHigh),
                  _sortTile('Price: High to Low', SortOption.priceHighLow),
                  _sortTile('Rating: High to Low', SortOption.ratingHighLow),
                  _sortTile('Title: A to Z', SortOption.titleAZ),
                  _sortTile('Title: Z to A', SortOption.titleZA),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _sortTile(String label, SortOption option) {
    final selected = _sort == option;
    return ListTile(
      title: Text(label),
      trailing: selected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () {
        setState(() => _sort = option);
        Navigator.pop(context);
      },
    );
  }

  void _openFilterSheet() {
    final categories =
        dummyProductList.map((e) => e.category.title).toSet().toList()..sort();

    Set<String> tempSelected = {..._selectedCategories};
    RangeValues tempRange = _priceRange;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Filters',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategories.clear();
                              _priceRange = RangeValues(_minPrice, _maxPrice);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final c in categories)
                          FilterChip(
                            label: Text(c),
                            selected: tempSelected.contains(c),
                            onSelected: (v) {
                              modalSetState(() {
                                if (v) {
                                  tempSelected.add(c);
                                } else {
                                  tempSelected.remove(c);
                                }
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Price range',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    RangeSlider(
                      values: tempRange,
                      min: _minPrice,
                      max: _maxPrice,
                      divisions: 20,
                      labels: RangeLabels(
                        tempRange.start.toStringAsFixed(0),
                        tempRange.end.toStringAsFixed(0),
                      ),
                      onChanged: (v) {
                        modalSetState(() {
                          tempRange = v;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '4 ${tempRange.start.toStringAsFixed(0)}'
                              .replaceFirst('\u0002', ''),
                        ),
                        Text(
                          '4 ${tempRange.end.toStringAsFixed(0)}'.replaceFirst(
                            '\u0002',
                            '',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedCategories = tempSelected;
                            _priceRange = tempRange;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                      MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              count > 9 ? '9+' : '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _query = v.trim()),
                  decoration: InputDecoration(
                    hintText: 'Search any Product',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: SizedBox(
                      width: _query.isNotEmpty ? 96 : 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (_query.isNotEmpty)
                            IconButton(
                              tooltip: 'Clear',
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                            ),
                          const Icon(Icons.camera_alt),
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${products.length}+ Items',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _openSortSheet,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.sort, size: 18),
                                SizedBox(width: 6),
                                Text('Sort', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: _openFilterSheet,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.tune, size: 18),
                                SizedBox(width: 6),
                                Text('Filter', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
