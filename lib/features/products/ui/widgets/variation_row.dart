import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/variation_dropdown.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/wishlist_widget.dart';

class VariationsRow extends StatelessWidget {
  const VariationsRow({
    super.key,
    required this.sizeOptions,
    required this.colorOptions,
    required this.storageOptions,
    required this.selectedSizeIndex,
    required this.selectedColorIndex,
    required this.selectedStorageIndex,
    required this.onSelectSize,
    required this.onSelectColor,
    required this.onSelectStorage,
    required this.products,
  });

  final List<String> sizeOptions;
  final List<String> colorOptions;
  final List<String> storageOptions;

  final int selectedSizeIndex;
  final int selectedColorIndex;
  final int selectedStorageIndex;

  final ValueChanged<int> onSelectSize;
  final ValueChanged<int> onSelectColor;
  final ValueChanged<int> onSelectStorage;

  final ProductsModel products;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (sizeOptions.isNotEmpty)
          Expanded(
            child: VariationDropdown(
              title: 'Size',
              values: sizeOptions,
              selectedIndex: selectedSizeIndex,
              onChanged: onSelectSize,
            ),
          ),
        Expanded(
          child: VariationDropdown(
            title: 'Color',
            values: colorOptions,
            selectedIndex: selectedColorIndex,
            onChanged: onSelectColor,
            showColorDot: true,
          ),
        ),
        if (storageOptions.isNotEmpty)
          Expanded(
            child: VariationDropdown(
              title: 'Storage',
              values: storageOptions,
              selectedIndex: selectedStorageIndex,
              onChanged: onSelectStorage,
            ),
          ),
        WishlistButton(products: products),
      ],
    );
  }
}
