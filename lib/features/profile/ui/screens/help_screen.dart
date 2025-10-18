import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = _dummyFaqs;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Help & FAQ', centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
        children: [
          for (final f in faqs)
            Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFEAEAEA)),
              ),
              child: ExpansionTile(
                shape: const Border(),
                title: Text(f.q, style: const TextStyle(fontWeight: FontWeight.w700)),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(f.a),
                  )
                ],
              ),
            ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report a problem')),
              ),
              child: const Text('Report a problem'),
            ),
          )
        ],
      ),
    );
  }
}

class _Faq {
  final String q, a;
  const _Faq(this.q, this.a);
}

const _dummyFaqs = <_Faq>[
  _Faq('How do I track my order?', 'You can track your order in the Orders section. Tap on an order to see its current status and tracking details.'),
  _Faq('What is the return policy?', 'Returns are accepted within 30 days of delivery for most items. Please keep the original packaging and receipt.'),
  _Faq('How do I apply a coupon?', 'Go to the Cart or Coupons screen and select a coupon. It will be applied during checkout.'),
];

