import 'package:flutter/material.dart';

/// Search input + “Items count” + Sort/Filter toolbar (preserves look & feel).
class SearchAndToolbar extends StatelessWidget {
  const SearchAndToolbar({
    super.key,
    required this.controller,
    required this.query,
    required this.itemCount,
    required this.onQueryChanged,
    required this.onClearQuery,
    required this.onTapSort,
    required this.onTapFilter,
  });

  final TextEditingController controller;
  final String query;
  final int itemCount;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onClearQuery;
  final VoidCallback onTapSort;
  final VoidCallback onTapFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          TextField(
            controller: controller,
            onChanged: onQueryChanged,
            decoration: InputDecoration(
              hintText: 'Search any Product',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: SizedBox(
                width: query.isNotEmpty ? 96 : 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (query.isNotEmpty)
                      IconButton(
                        tooltip: 'Clear',
                        icon: const Icon(Icons.clear),
                        onPressed: onClearQuery,
                      ),
                    const Icon(Icons.camera_alt),
                    const SizedBox(width: 16),
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
                  '$itemCount+ Items',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: [
                  ToolbarButton(
                    icon: Icons.sort,
                    label: 'Sort',
                    onTap: onTapSort,
                  ),
                  const SizedBox(width: 12),
                  ToolbarButton(
                    icon: Icons.tune,
                    label: 'Filter',
                    onTap: onTapFilter,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The small pill-like toolbar button used for Sort & Filter.
class ToolbarButton extends StatelessWidget {
  const ToolbarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
