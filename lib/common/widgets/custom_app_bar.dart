import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? middle;
  final Color? backgroundColor;
  final bool centerTitle;
  final VoidCallback? onBack;
  final IconData? rightIcon;
  final VoidCallback? onRight;
  final int? rightBadgeCount;

  const CustomAppBar({
    super.key,
    this.title,
    this.middle,
    this.backgroundColor,
    this.centerTitle = false,
    this.onBack,
    this.rightIcon,
    this.onRight,
    this.rightBadgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final bool showBack = onBack != null || Navigator.canPop(context);
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Builder(
          builder: (context) {
            if (middle != null) {
              return Row(
                children: [
                  if (showBack)
                    _BackButton(
                      onPressed: onBack ?? () => Navigator.maybePop(context),
                    ),
                  if (showBack) const SizedBox(width: 12),
                  Expanded(child: middle!),
                  if (rightIcon != null) const SizedBox(width: 12),
                  if (rightIcon != null)
                    _ActionButton(
                      icon: rightIcon!,
                      onPressed: onRight ?? () {},
                      badgeCount: rightBadgeCount,
                    ),
                ],
              );
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                if (showBack)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _BackButton(
                      onPressed: onBack ?? () => Navigator.maybePop(context),
                    ),
                  ),
                if (title != null)
                  centerTitle
                      ? Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            child: Text(
                              title!,
                              key: ValueKey(title),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 56),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: _TitleProxy(),
                          ),
                        ),
                if (rightIcon != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: _ActionButton(
                      icon: rightIcon!,
                      onPressed: onRight ?? () {},
                      badgeCount: rightBadgeCount,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _BackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF2F2F2),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: const SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final int? badgeCount;
  const _ActionButton({required this.icon, required this.onPressed, this.badgeCount});

  @override
  Widget build(BuildContext context) {
    final int count = badgeCount ?? 0;
    return Material(
      color: const Color(0xFFF2F2F2),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(width: 36, height: 36),
            const Positioned.fill(
              child: Center(
                child: SizedBox(
                  width: 36,
                  height: 36,
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Icon(icon, size: 20, color: Colors.black87),
              ),
            ),
            Positioned(
              right: -2,
              top: -2,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 160),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, anim) {
                  return FadeTransition(
                    opacity: anim,
                    child: ScaleTransition(scale: Tween(begin: 0.9, end: 1.0).animate(anim), child: child),
                  );
                },
                child: count > 0
                    ? Container(
                        key: ValueKey('badge-$count'),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          count > 9 ? '9+' : '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('badge-0')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper to keep text style consistent when not centering
class _TitleProxy extends StatelessWidget {
  const _TitleProxy();

  @override
  Widget build(BuildContext context) {
    final parent = context
        .findAncestorWidgetOfExactType<CustomAppBar>();
    final title = parent?.title ?? '';
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: Text(
        title,
        key: ValueKey(title),
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
