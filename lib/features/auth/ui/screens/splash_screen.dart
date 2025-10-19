import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/app/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _bgController;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _glowScale;
  late final Animation<Alignment> _gradBegin;
  late final Animation<Alignment> _gradEnd;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ).drive(Tween(begin: 0.85, end: 1.0));
    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );

    _controller.forward();

    // Subtle animated background sweep and pulsing glow
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _glowScale = Tween(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _bgController, curve: Curves.easeInOut));
    _gradBegin = AlignmentTween(
      begin: const Alignment(-1.0, -0.8),
      end: const Alignment(0.8, -1.0),
    ).animate(CurvedAnimation(parent: _bgController, curve: Curves.easeInOut));
    _gradEnd = AlignmentTween(
      begin: const Alignment(1.0, 0.8),
      end: const Alignment(-0.8, 1.0),
    ).animate(CurvedAnimation(parent: _bgController, curve: Curves.easeInOut));

    // Allow extra time for tagline + background to play nicely
    Timer(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Animated gradient background
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, _) {
              final primary = AppColors.primaryColor;
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: _gradBegin.value,
                    end: _gradEnd.value,
                    colors: [
                      primary.withValues(alpha: 0.92),
                      primary,
                      primary.withValues(alpha: 0.92),
                    ],
                  ),
                ),
              );
            },
          ),
          // Logo + glow + tagline
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 220,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Soft pulsing glow behind the logo
                      AnimatedBuilder(
                        animation: _bgController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _glowScale.value,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.22),
                                    Colors.white.withValues(alpha: 0.0),
                                  ],
                                  stops: const [0.0, 1.0],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Logo
                      FadeTransition(
                        opacity: _fadeAnim,
                        child: ScaleTransition(
                          scale: _scaleAnim,
                          child: SvgPicture.asset(
                            AssetsPath.logoSvg,
                            width: 200,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Tagline slide + fade in
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
                  ),
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0, 0.25),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: const Interval(
                              0.35,
                              1.0,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                        ),
                    child: const Text(
                      'Powered by WooClot',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _bgController.dispose();
    super.dispose();
  }
}
