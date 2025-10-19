import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_theme.dart';
import 'package:flutter_woocommerce/app/routes.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/order/providers/orders_provider.dart';
import 'package:flutter_woocommerce/features/notifications/providers/notifications_provider.dart';
import 'package:flutter_woocommerce/features/wishlist/providers/wishlist_provider.dart';
import 'package:flutter_woocommerce/features/products/providers/shop_search_provider.dart';
import 'package:flutter_woocommerce/features/home/data/bottom_nav_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/address_provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/payment_methods_provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/profile_provider.dart';
import 'package:flutter_woocommerce/common/utils/unfocus.dart';
import 'package:flutter_woocommerce/common/utils/smooth_scroll_behavior.dart';
import 'package:flutter_woocommerce/app/app_config.dart';

class WooClot extends StatelessWidget {
  const WooClot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final p = CartProvider();
          if (AppConfig.useDummyData) p.seedDummy();
          return p;
        }),
        ChangeNotifierProvider(create: (_) {
          final p = WishlistProvider();
          if (AppConfig.useDummyData) p.seedDummy();
          return p;
        }),
        ChangeNotifierProvider(create: (_) => ShopSearchProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavController()),
        ChangeNotifierProvider(create: (_) {
          final p = NotificationsProvider();
          if (AppConfig.useDummyData) p.seedDummy();
          return p;
        }),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => PaymentMethodsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) {
          final p = OrdersProvider();
          if (AppConfig.useDummyData) p.seedDummy();
          return p;
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        scrollBehavior: const SmoothScrollBehavior(),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
        builder: (context, child) =>
            UnfocusOnTap(child: child ?? const SizedBox.shrink()),
        navigatorObservers: [UnfocusNavigatorObserver()],
      ),
    );
  }
}
