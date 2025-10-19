import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool push = true;
  bool email = true;
  bool newsletter = false;
  bool location = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings', centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
        children: [
          _switch('Push Notifications', push, (v) => setState(() => push = v)),
          _switch('Email Updates', email, (v) => setState(() => email = v)),
          _switch(
            'Newsletter',
            newsletter,
            (v) => setState(() => newsletter = v),
          ),
          _switch(
            'Location Services',
            location,
            (v) => setState(() => location = v),
          ),
        ],
      ),
    );
  }

  Widget _switch(String title, bool value, ValueChanged<bool> onChanged) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: SwitchListTile(
        activeThumbColor: AppColors.primaryColor,
        inactiveThumbColor: AppColors.primaryColor,
        inactiveTrackColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
