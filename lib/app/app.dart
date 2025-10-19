import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_theme.dart';
import 'package:flutter_woocommerce/app/routes.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/order/providers/orders_provider.dart';
import 'package:flutter_woocommerce/features/notifications/providers/notifications_provider.dart';
import 'package:flutter_woocommerce/features/wishlist/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/address_provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/payment_methods_provider.dart';
import 'package:flutter_woocommerce/features/profile/providers/profile_provider.dart';

class WooClot extends StatelessWidget {
  const WooClot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()..seedDummy()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()..seedDummy()),
        ChangeNotifierProvider(
          create: (_) => NotificationsProvider()..seedDummy(),
        ),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => PaymentMethodsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()..seedDummy()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
