import 'package:flutter/material.dart';

class AppCircleButton extends StatelessWidget {
  AppCircleButton({
    super.key,
    required this.child,
    this.color,
    this.width = 60,
    this.onTap,
    this.paddingLR = 10,
    this.paddingTB = 10,
  });
  final Widget child;
  final Color? color;
  final double? width;
  final VoidCallback? onTap;
  double paddingLR;
  double paddingTB;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      shape: CircleBorder(),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: paddingLR, vertical: paddingTB),
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
