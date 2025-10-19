import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/features/wishlist/ui/screens/wishlist_screen.dart';
import 'package:flutter_woocommerce/app/routes.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/orders_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/addresses_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/payment_methods_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/coupons_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/edit_profile_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/settings_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/contact_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/help_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/change_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(),
              const SizedBox(height: 16),
              _SectionLabel('Shopping'),
              _Tile(
                icon: Icons.receipt_long,
                label: 'Orders',
                onTap: () => _open(context, const OrdersScreen()),
              ),
              _Tile(
                icon: Icons.favorite,
                label: 'Wishlist',
                onTap: () => _open(context, const WishlistScreen()),
              ),
              _Tile(
                icon: Icons.location_on_outlined,
                label: 'Addresses',
                onTap: () => _open(context, const AddressesScreen()),
              ),
              _Tile(
                icon: Icons.credit_card,
                label: 'Payment Methods',
                onTap: () => _open(context, const PaymentMethodsScreen()),
              ),
              _Tile(
                icon: Icons.local_offer_outlined,
                label: 'Coupons',
                onTap: () => _open(context, const CouponsScreen()),
              ),
              const SizedBox(height: 12),

              // Account
              _SectionLabel('Account Settings'),
              _Tile(
                icon: Icons.person_outline,
                label: 'Profile',
                onTap: () => _open(context, const EditProfileScreen()),
              ),
              _Tile(
                icon: Icons.lock_outline,
                label: 'Change Password',
                onTap: () => _open(context, const ChangePasswordScreen()),
              ),
              _Tile(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () => _open(context, const SettingsScreen()),
              ),
              _Tile(
                icon: Icons.mail_outline,
                label: 'Contact',
                onTap: () => _open(context, const ContactScreen()),
              ),
              _Tile(
                icon: Icons.share_outlined,
                label: 'Share App',
                onTap: () {
                  Clipboard.setData(
                    const ClipboardData(text: 'https://example.com/app'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share link copied')),
                  );
                },
              ),
              _Tile(
                icon: Icons.help_outline,
                label: 'Help',
                onTap: () => _open(context, const HelpScreen()),
              ),

              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(AssetsPath.user, fit: BoxFit.cover),
        ),
        const SizedBox(height: 12),
        Text(
          profile.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Text(profile.email, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _Tile({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: AppColors.primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.black38),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
