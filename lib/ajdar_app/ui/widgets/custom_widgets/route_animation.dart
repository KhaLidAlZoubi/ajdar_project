import 'package:flutter/material.dart';

class CustomPageTransition {
  static Route createRoute({
    required Widget page,

    // ذكي: حالات الاستخدام
    bool isModal = false,
    bool isBack = false,
    bool isQuietPage = false,
    bool isHeroStyle = false,
    bool isComplexPage = false,

    // يدوي (لمن يريد تخصيص مباشر)
    bool fade = false,
    bool slideRightToLeft = false,
    bool slideLeftToRight = false,
    bool bottomToTop = false,
    bool scale = false,
    bool rotation = false,
    bool size = false,
    bool zoom = false,
    bool leftToRightWithFade = false,

    // إعدادات عامة
    Duration duration = const Duration(milliseconds: 600),
    Duration reverseDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
  }) {
    // التوجيه الذكي: تحديد الأنميشن المناسب تلقائيًا
    if (isModal)
      bottomToTop = true;
    else if (isBack)
      leftToRightWithFade = true;
    else if (isQuietPage)
      fade = true;
    else if (isHeroStyle)
      zoom = true;
    else if (isComplexPage) scale = true;

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: reverseDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnim = CurvedAnimation(parent: animation, curve: curve);

        if (fade) {
          return FadeTransition(opacity: curvedAnim, child: child);
        }

        if (slideRightToLeft) {
          return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                .animate(curvedAnim),
            child: child,
          );
        }

        if (slideLeftToRight) {
          return SlideTransition(
            position: Tween(begin: Offset(-1.0, 0.0), end: Offset.zero)
                .animate(curvedAnim),
            child: child,
          );
        }

        if (bottomToTop) {
          return SlideTransition(
            position: Tween(begin: Offset(0.0, 1.0), end: Offset.zero)
                .animate(curvedAnim),
            child: child,
          );
        }

        if (scale) {
          return ScaleTransition(scale: curvedAnim, child: child);
        }

        if (rotation) {
          return RotationTransition(turns: curvedAnim, child: child);
        }

        if (size) {
          return Align(
            alignment: Alignment.center,
            child: SizeTransition(sizeFactor: curvedAnim, child: child),
          );
        }

        if (zoom) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnim),
            child: FadeTransition(opacity: curvedAnim, child: child),
          );
        }

        if (leftToRightWithFade) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                .animate(curvedAnim),
            child: FadeTransition(opacity: curvedAnim, child: child),
          );
        }

        return child;
      },
    );
  }
}
