import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Contact', centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Row(icon: Icons.email_outlined, label: 'support@example.com'),
            const SizedBox(height: 12),
            _Row(icon: Icons.phone_outlined, label: '+1 212 555 0000'),
            const SizedBox(height: 12),
            _Row(icon: Icons.timer_outlined, label: 'Mon–Fri, 9:00 AM – 6:00 PM'),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _snack(context, 'Email us'),
                    icon: const Icon(Icons.email_outlined),
                    label: const Text('Email Us'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _snack(context, 'Call us'),
                    icon: const Icon(Icons.call),
                    label: const Text('Call Us'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _snack(BuildContext context, String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Row({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.black87),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

