import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/app/routes.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String contact;
  const ResetPasswordScreen({super.key, required this.contact});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _showPass = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _save() {
    final p = _pass.text.trim();
    final c = _confirm.text.trim();
    if (p.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }
    if (p != c) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset for ${widget.contact}')),
    );
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reset Password', centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a new password for your account.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _pass,
                obscureText: !_showPass,
                decoration: InputDecoration(
                  labelText: 'New password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: Icon(_showPass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _showPass = !_showPass),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirm,
                obscureText: !_showConfirm,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: Icon(_showConfirm ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _showConfirm = !_showConfirm),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  onPressed: _save,
                  child: const Text(
                    'Save Password',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

