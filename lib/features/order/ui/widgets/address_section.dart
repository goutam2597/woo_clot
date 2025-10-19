import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/profile/providers/address_provider.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  const AddressCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFF2F2F2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.location_on, color: AppColors.themeColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
        if (trailing != null) const SizedBox(width: 12),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class AddressPickerSheet extends StatefulWidget {
  const AddressPickerSheet({
    super.key,
    required this.selectedId,
    required this.controller,
  });

  final String selectedId;
  final AddressProvider controller;

  @override
  State<AddressPickerSheet> createState() => _AddressPickerSheetState();
}

class _AddressPickerSheetState extends State<AddressPickerSheet> {
  late String selectedId;

  @override
  void initState() {
    super.initState();
    selectedId = widget.selectedId;
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose Shipping Address',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final a in ctrl.items)
                    InkWell(
                      onTap: () => setState(() => selectedId = a.id),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _radioVisual(selectedId == a.id),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${a.name} • ${a.line1}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${a.city}, ${a.state} ${a.zip}\n${a.phone}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                onPressed: () {
                  ctrl.setDefault(selectedId);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Use This Address',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container _radioVisual(bool checked) {
  return Container(
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: checked ? AppColors.themeColor : Colors.black26,
        width: checked ? 6 : 1.5,
      ),
    ),
  );
}
