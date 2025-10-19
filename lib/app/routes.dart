import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/features/auth/ui/screens/login_screen.dart';
import 'package:flutter_woocommerce/features/auth/ui/screens/sign_up_screen.dart';
import 'package:flutter_woocommerce/features/auth/ui/screens/splash_screen.dart';
import 'package:flutter_woocommerce/features/home/ui/screens/bottom_nav.dart';
import 'package:flutter_woocommerce/features/home/ui/screens/home_screen.dart';
import 'package:flutter_woocommerce/features/auth/ui/screens/forgot_password_screen.dart';
import 'package:flutter_woocommerce/features/auth/ui/screens/otp_screen.dart';
import 'package:flutter_woocommerce/features/auth/ui/screens/reset_password_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
  static const String bottomNav = '/nav';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.verifyOtp:
        final args = settings.arguments as Map<String, dynamic>?;
        final contact = args?['contact'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => OtpVerifyScreen(contact: contact),
        );
      case AppRoutes.resetPassword:
        final args = settings.arguments as Map<String, dynamic>?;
        final contact = args?['contact'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(contact: contact),
        );
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.bottomNav:
        return MaterialPageRoute(builder: (_) => const BottomNav());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Page not found')),
            body: Center(child: Text('No route defined for: ${settings.name}')),
          ),
        );
    }
  }
}
