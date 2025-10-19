import 'package:flutter/material.dart';

/// Wraps the entire app and dismisses keyboard focus when tapping anywhere
/// outside of a focused field.
class UnfocusOnTap extends StatelessWidget {
  final Widget child;
  const UnfocusOnTap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Use Listener so we don't compete in the gesture arena and block taps.
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}

/// Navigator observer that dismisses keyboard on route changes.
class UnfocusNavigatorObserver extends NavigatorObserver {
  void _dismiss() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _dismiss();
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _dismiss();
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _dismiss();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _dismiss();
    super.didRemove(route, previousRoute);
  }
}
