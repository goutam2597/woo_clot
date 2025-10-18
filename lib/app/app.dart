import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_theme.dart';
import 'package:flutter_woocommerce/app/routes.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:flutter_woocommerce/features/wishlist/data/wishlist_provider.dart';
import 'package:flutter_woocommerce/features/order/data/orders_provider.dart';
import 'package:flutter_woocommerce/features/notifications/data/notifications_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/profile/data/address_provider.dart';
import 'package:flutter_woocommerce/features/profile/data/payment_methods_provider.dart';
import 'package:flutter_woocommerce/features/profile/data/profile_provider.dart';

class WooClot extends StatelessWidget {
  const WooClot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartController()..seedDummy()),
        ChangeNotifierProvider(create: (_) => WishlistController()..seedDummy()),
        ChangeNotifierProvider(create: (_) => NotificationsController()..seedDummy()),
        ChangeNotifierProvider(create: (_) => AddressController()),
        ChangeNotifierProvider(create: (_) => PaymentMethodsController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => OrdersController()..seedDummy()),
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
