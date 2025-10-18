import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/profile/data/address_provider.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = context.watch<AddressController>().items;
    final ctrl = context.read<AddressController>();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Addresses', centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          for (final a in addresses)
            _AddressCard(
              addr: a,
              onEdit: () => _showAddressSheet(context, initial: a),
              onDelete: () async {
                final ok = await _confirm(context, 'Delete ${a.name} address?');
                if (ok) ctrl.remove(a.id);
              },
              onMakeDefault: () => ctrl.setDefault(a.id),
            ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                shape: const StadiumBorder(),
                elevation: 0,
              ),
              onPressed: () => _showAddressSheet(context),
              child: const Text('Add New Address', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddressSheet(BuildContext context, {AddressModel? initial}) async {
    final ctrl = context.read<AddressController>();
    final name = TextEditingController(text: initial?.name ?? '');
    final line1 = TextEditingController(text: initial?.line1 ?? '');
    final city = TextEditingController(text: initial?.city ?? '');
    final state = TextEditingController(text: initial?.state ?? '');
    final zip = TextEditingController(text: initial?.zip ?? '');
    final phone = TextEditingController(text: initial?.phone ?? '');
    bool makeDefault = initial?.isDefault ?? false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: StatefulBuilder(builder: (ctx, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  initial == null ? 'Add Address' : 'Edit Address',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                _field('Label', name),
                const SizedBox(height: 8),
                _field('Address Line', line1),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(child: _field('City', city)),
                  const SizedBox(width: 8),
                  Expanded(child: _field('State', state)),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(child: _field('ZIP', zip, keyboardType: TextInputType.number)),
                  const SizedBox(width: 8),
                  Expanded(child: _field('Phone', phone, keyboardType: TextInputType.phone)),
                ]),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: makeDefault,
                      onChanged: (v) => setState(() => makeDefault = v ?? false),
                    ),
                    const Text('Set as default')
                  ],
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
                      if (initial == null) {
                        final id = DateTime.now().millisecondsSinceEpoch.toString();
                        final a = AddressModel(
                          id: id,
                          name: name.text.trim(),
                          line1: line1.text.trim(),
                          city: city.text.trim(),
                          state: state.text.trim(),
                          zip: zip.text.trim(),
                          phone: phone.text.trim(),
                          isDefault: makeDefault,
                        );
                        ctrl.add(a);
                        if (makeDefault) ctrl.setDefault(id);
                      } else {
                        initial
                          ..name = name.text.trim()
                          ..line1 = line1.text.trim()
                          ..city = city.text.trim()
                          ..state = state.text.trim()
                          ..zip = zip.text.trim()
                          ..phone = phone.text.trim()
                          ..isDefault = makeDefault;
                        ctrl.update(initial);
                        if (makeDefault) ctrl.setDefault(initial.id);
                      }
                      Navigator.pop(ctx);
                    },
                    child: Text(initial == null ? 'Add Address' : 'Save Changes',
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Future<bool> _confirm(BuildContext context, String msg) async {
    final r = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm'),
        content: Text(msg),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    return r ?? false;
  }
}

Widget _field(String label, TextEditingController c, {TextInputType? keyboardType}) {
  return TextField(
    controller: c,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
      ),
    ),
  );
}

class _AddressCard extends StatelessWidget {
  final AddressModel addr;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onMakeDefault;
  const _AddressCard({required this.addr, required this.onEdit, required this.onDelete, required this.onMakeDefault});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        title: Row(
          children: [
            Text(addr.name, style: const TextStyle(fontWeight: FontWeight.w700)),
            if (addr.isDefault) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Default', style: TextStyle(color: AppColors.themeColor, fontSize: 12, fontWeight: FontWeight.w700)),
              ),
            ]
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(addr.line1),
              Text('${addr.city}, ${addr.state} ${addr.zip}'),
              Text('Phone: ${addr.phone}'),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!addr.isDefault)
              IconButton(
                tooltip: 'Make default',
                icon: const Icon(Icons.star_border, color: Colors.black54),
                onPressed: onMakeDefault,
              ),
            IconButton(
              tooltip: 'Edit',
              icon: const Icon(Icons.edit, color: Colors.black54),
              onPressed: onEdit,
            ),
            IconButton(
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline, color: Colors.black54),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

