import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Change Password', centerTitle: true),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _pwd(
              'Current Password',
              _current,
              _obscureCurrent,
              () => setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            const SizedBox(height: 12),
            _pwd(
              'New Password',
              _new,
              _obscureNew,
              () => setState(() => _obscureNew = !_obscureNew),
            ),
            const SizedBox(height: 12),
            _pwd(
              'Confirm Password',
              _confirm,
              _obscureConfirm,
              () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                onPressed: _onSubmit,
                child: const Text(
                  'Change Password',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    final newPwd = _new.text.trim();
    final confirmPwd = _confirm.text.trim();
    if (newPwd.isEmpty || confirmPwd.isEmpty || newPwd != confirmPwd) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    // Demo only: Show success.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Password changed')));
    _current.clear();
    _new.clear();
    _confirm.clear();
  }

  Widget _pwd(
    String label,
    TextEditingController c,
    bool obscure,
    VoidCallback toggle,
  ) {
    return TextField(
      controller: c,
      obscureText: obscure,
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
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: toggle,
        ),
      ),
    );
  }
}
