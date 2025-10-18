import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';

class VariationDropdown extends StatelessWidget {
  final String title;
  final List<String> values;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final bool showColorDot;

  const VariationDropdown({
    super.key,
    required this.title,
    required this.values,
    required this.selectedIndex,
    required this.onChanged,
    this.showColorDot = false,
  });

  Color _colorFromName(String name) {
    switch (name.trim().toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'cyan':
        return Colors.cyan;
      case 'teal':
        return Colors.teal;
      case 'brown':
        return Colors.brown;
      case 'indigo':
        return Colors.indigo;
      case 'grey':
      case 'gray':
        return Colors.grey;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox.shrink();

    final primary = AppColors.themeColor;
    final radius = BorderRadius.circular(8);

    void openPicker() {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Select $title',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: values.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, color: AppColors.themeColor),
                  itemBuilder: (ctx, index) {
                    final value = values[index];
                    final selected = index == selectedIndex;
                    return ListTile(
                      onTap: () {
                        Navigator.pop(ctx);
                        onChanged(index);
                      },
                      leading: showColorDot
                          ? Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _colorFromName(value),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                            )
                          : null,
                      title: Text(value),
                      trailing: selected
                          ? Icon(Icons.check, color: primary)
                          : null,
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: InkWell(
        borderRadius: radius,
        onTap: openPicker,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: AppColors.themeColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  values[selectedIndex],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
