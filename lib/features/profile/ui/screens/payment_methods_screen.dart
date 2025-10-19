import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/profile/data/models/payment_method_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/payment_methods_provider.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final methods = context.watch<PaymentMethodsProvider>().items;
    final ctrl = context.read<PaymentMethodsProvider>();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Payment Methods', centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          for (final m in methods)
            _MethodTile(
              method: m,
              onEdit: () => _showMethodSheet(context, initial: m),
              onDelete: () => ctrl.remove(m.id),
            ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: const StadiumBorder(),
                elevation: 0,
              ),
              onPressed: () => _showMethodSheet(context),
              child: const Text(
                'Add Payment Method',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMethodSheet(
    BuildContext context, {
    PaymentMethodModel? initial,
  }) async {
    final ctrl = context.read<PaymentMethodsProvider>();
    PaymentType type = initial?.type ?? PaymentType.visa;
    final label = TextEditingController(
      text:
          initial?.label ??
          (type == PaymentType.paypal
              ? 'PayPal'
              : type == PaymentType.visa
              ? 'Visa'
              : 'Mastercard'),
    );
    final details = TextEditingController(text: initial?.details ?? '');

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
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    initial == null
                        ? 'Add Payment Method'
                        : 'Edit Payment Method',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<PaymentType>(
                    initialValue: type,
                    items: const [
                      DropdownMenuItem(
                        value: PaymentType.visa,
                        child: Text('Visa'),
                      ),
                      DropdownMenuItem(
                        value: PaymentType.mastercard,
                        child: Text('Mastercard'),
                      ),
                      DropdownMenuItem(
                        value: PaymentType.paypal,
                        child: Text('PayPal'),
                      ),
                    ],
                    onChanged: (v) => setState(() => type = v ?? type),
                    decoration: _inputDecor('Type'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: label,
                    decoration: _inputDecor('Label'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: details,
                    decoration: _inputDecor(
                      type == PaymentType.paypal
                          ? 'PayPal Email'
                          : 'Card (masked) e.g., **** 4242',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: const StadiumBorder(),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (initial == null) {
                          ctrl.add(
                            PaymentMethodModel(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              type: type,
                              label: label.text.trim(),
                              details: details.text.trim(),
                            ),
                          );
                        } else {
                          ctrl.update(
                            PaymentMethodModel(
                              id: initial.id,
                              type: type,
                              label: label.text.trim(),
                              details: details.text.trim(),
                            ),
                          );
                        }
                        Navigator.pop(ctx);
                      },
                      child: Text(
                        initial == null ? 'Add Method' : 'Save Changes',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _MethodTile extends StatelessWidget {
  final PaymentMethodModel method;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _MethodTile({
    required this.method,
    required this.onEdit,
    required this.onDelete,
  });

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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
          child: Icon(_iconFor(method.type), color: AppColors.primaryColor),
        ),
        title: Text(
          method.label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(method.details),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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

InputDecoration _inputDecor(String label) => InputDecoration(
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
);

IconData _iconFor(PaymentType t) {
  switch (t) {
    case PaymentType.visa:
      return Icons.credit_card;
    case PaymentType.mastercard:
      return Icons.credit_card;
    case PaymentType.paypal:
      return Icons.account_balance_wallet;
  }
}
