import 'package:flutter/material.dart';

class SortSheet extends StatelessWidget {
  const SortSheet({super.key, required this.current});

  final SortOption current;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final maxH = MediaQuery.of(ctx).size.height * 0.8;
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxH),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'Sort by',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  SortTile(
                    label: 'Relevance',
                    option: SortOption.relevance,
                    current: current,
                  ),
                  SortTile(
                    label: 'Price: Low to High',
                    option: SortOption.priceLowHigh,
                    current: current,
                  ),
                  SortTile(
                    label: 'Price: High to Low',
                    option: SortOption.priceHighLow,
                    current: current,
                  ),
                  SortTile(
                    label: 'Rating: High to Low',
                    option: SortOption.ratingHighLow,
                    current: current,
                  ),
                  SortTile(
                    label: 'Title: A to Z',
                    option: SortOption.titleAZ,
                    current: current,
                  ),
                  SortTile(
                    label: 'Title: Z to A',
                    option: SortOption.titleZA,
                    current: current,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SortTile extends StatelessWidget {
  const SortTile({
    super.key,
    required this.label,
    required this.option,
    required this.current,
  });

  final String label;
  final SortOption option;
  final SortOption current;

  @override
  Widget build(BuildContext context) {
    final selected = current == option;
    return ListTile(
      title: Text(label),
      trailing: selected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () => Navigator.pop(context, option),
    );
  }
}

enum SortOption {
  relevance,
  priceLowHigh,
  priceHighLow,
  ratingHighLow,
  titleAZ,
  titleZA,
}
