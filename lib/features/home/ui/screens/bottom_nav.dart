import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/products/providers/shop_search_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/home/ui/screens/home_screen.dart';
import 'package:flutter_woocommerce/features/cart/ui/screens/cart_screen.dart';
import 'package:flutter_woocommerce/features/products/ui/screens/all_products.dart';
import 'package:flutter_woocommerce/features/wishlist/ui/screens/wishlist_screen.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/profile_screen.dart';
import 'package:flutter_woocommerce/features/home/data/bottom_nav_controller.dart';

const int kHome = 0;
const int kStore = 1;
const int kCart = 2;
const int kOrders = 3;
const int kProfile = 4;

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  const KeepAliveWrapper({super.key, required this.child});

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late final PageController _pageController;
  int _currentIndex = kHome;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);

    _pages = [
      KeepAliveWrapper(child: HomeScreen(onRequestTabChange: _onTapNav)),
      KeepAliveWrapper(child: AllProducts()),
      KeepAliveWrapper(child: CartScreen()),
      KeepAliveWrapper(child: WishlistScreen()),
      KeepAliveWrapper(child: ProfileScreen()),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTapNav(int index) {
    // Dismiss any focused text fields (e.g., search) on navigation
    FocusManager.instance.primaryFocus?.unfocus();
    // Clear shop search when leaving the Shop tab
    if (_currentIndex == kStore && index != kStore) {
      context.read<ShopSearchProvider>().clear();
    }
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    // Keep global BottomNavController in sync to avoid forced reverts
    context.read<BottomNavController>().goTo(index);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final requestedIndex = context.watch<BottomNavController>().index;
    if (requestedIndex != _currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onTapNav(requestedIndex);
      });
    }
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Container(
              color: Colors.white,
              child: PageView(
                controller: _pageController,
                allowImplicitScrolling: true,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) {
                  // Also dismiss focus when page changes programmatically
                  FocusManager.instance.primaryFocus?.unfocus();
                  // Clear provider search if not on Shop tab
                  if (i != kStore) {
                    context.read<ShopSearchProvider>().clear();
                  }
                  setState(() => _currentIndex = i);
                  // Ensure provider reflects actual page selection
                  context.read<BottomNavController>().goTo(i);
                },
                children: _pages,
              ),
            ),
          ),
          bottomNavigationBar: _FloatingPillBar(
            currentIndex: _currentIndex,
            onTap: _onTapNav,
          ),
        ),
      ),
    );
  }
}

class _FloatingPillBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingPillBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final badgeCount = context.watch<CartProvider>().totalQuantity;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 12),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavCapsule(
              index: kHome,
              label: 'Home',
              icon: AssetsPath.homeSvg,
              isSelected: currentIndex == kHome,
              onTap: onTap,
            ),
            _NavCapsule(
              index: kStore,
              label: 'Shop',
              icon: AssetsPath.shopSvg,
              isSelected: currentIndex == kStore,
              onTap: onTap,
            ),
            _NavCapsule(
              index: kCart,
              label: 'Cart',
              icon: AssetsPath.cartSvg,
              isSelected: currentIndex == kCart,
              onTap: onTap,
              badgeCount: badgeCount,
            ),
            _NavCapsule(
              index: kOrders,
              label: 'Wishlist',
              icon: AssetsPath.wishSvg,
              isSelected: currentIndex == kOrders,
              onTap: onTap,
            ),
            _NavCapsule(
              index: kProfile,
              label: 'Profile',
              icon: AssetsPath.userSvg,
              isSelected: currentIndex == kProfile,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavCapsule extends StatelessWidget {
  final int index;
  final String label;
  final String icon;
  final bool isSelected;
  final ValueChanged<int> onTap;
  final int badgeCount;

  const _NavCapsule({
    required this.index,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = AppColors.themeColor;
    final Color iconColor = isSelected ? accent : Colors.black87;
    final Color textColor = isSelected ? accent : Colors.black87;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? accent.withAlpha(12) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                  if (badgeCount > 0 && index == kCart)
                    Positioned(
                      right: -8,
                      top: -6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          badgeCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
