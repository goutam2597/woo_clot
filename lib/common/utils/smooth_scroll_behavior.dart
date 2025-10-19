import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Globally apply gentle, platform-appropriate scroll with bounce on touch devices
class SmoothScrollBehavior extends MaterialScrollBehavior {
  const SmoothScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    final platform = Theme.of(context).platform;
    // Keep iOS/macOS bounce, give Android/others a subtle bounce for smoothness
    final physics = platform == TargetPlatform.iOS || platform == TargetPlatform.macOS
        ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
        : const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
    return physics;
  }
}

