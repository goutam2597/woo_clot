
import 'package:flutter/material.dart';

class FilterResult {
  FilterResult({
    required this.selected,
    required this.range,
    this.reset = false,
  });

  final Set<String> selected;
  final RangeValues range;
  final bool reset;
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key,
    required this.categories,
    required this.selected,
    required this.currentRange,
    required this.minPrice,
    required this.maxPrice,
  });

  final List<String> categories;
  final Set<String> selected;
  final RangeValues currentRange;
  final double minPrice;
  final double maxPrice;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late Set<String> tempSelected;
  late RangeValues tempRange;

  @override
  void initState() {
    super.initState();
    tempSelected = {...widget.selected};
    tempRange = widget.currentRange;
  }

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Same behavior as original: reset immediately & close.
                    Navigator.pop(
                      context,
                      FilterResult(
                        selected: <String>{},
                        range: RangeValues(widget.minPrice, widget.maxPrice),
                        reset: true,
                      ),
                    );
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
                for (final c in widget.categories)
                  FilterChip(
                    label: Text(c),
                    selected: tempSelected.contains(c),
                    onSelected: (v) {
                      setState(() {
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
              min: widget.minPrice,
              max: widget.maxPrice,
              divisions: 20,
              labels: RangeLabels(
                tempRange.start.toStringAsFixed(0),
                tempRange.end.toStringAsFixed(0),
              ),
              onChanged: (v) => setState(() => tempRange = v),
            ),

            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '4 ${tempRange.start.toStringAsFixed(0)}'.replaceFirst(
                    '\u0002',
                    '',
                  ),
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
                  Navigator.pop(
                    context,
                    FilterResult(selected: tempSelected, range: tempRange),
                  );
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
