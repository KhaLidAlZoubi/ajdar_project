// ignore_for_file: must_be_immutable

import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

import '../../../confirm/theme/sub_theme_data.dart';
import 'package:flutter/material.dart';

import '../../../confirm/theme/sub_theme_data.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key? key,
    required this.onTap,
    this.h = 45,
    this.w = double.infinity,
    this.r = 7,
    this.s = 13,
    this.text = '',
    this.color = AppLightColors.primaryColor,
    this.textColor = Colors.white,
    this.icon,
    this.iconSize = 30,
    this.alignment = MainAxisAlignment.start,
    this.borderColor,
    this.padding = 0,
    this.child,
    this.isShadow = false,
    this.assets = '',
  }) : super(key: key);
  final void Function() onTap;
  double h;
  double w;
  double r;
  double s;
  Color color;
  String text;
  Color textColor;
  IconData? icon;
  double iconSize;
  MainAxisAlignment alignment;
  Color? borderColor;
  double padding;
  Widget? child;
  bool isShadow;
  String assets;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r),
      child: Container(
        height: h,
        width: w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: getRes(context, padding),
        ),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor ?? color,
          ),
          borderRadius: BorderRadius.circular(r),
          boxShadow: isShadow == false
              ? [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: shadowTextThemeColor,
                    blurRadius: 20,
                  )
                ]
              : null,
        ),
        child: child == null
            ? text != '' && icon == null
                ? SubtitleText(
                    text,
                    weight: FontWeight.w500,
                    color: textColor,
                    fontSize: s,
                  )
                : text == '' && icon != null
                    ? Align(
                        alignment: Alignment.center,
                        child: Icon(
                          icon,
                          size: iconSize,
                          color: textColor,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: alignment,
                        children: [
                          Icon(
                            icon,
                            size: iconSize,
                            color: textColor,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          SubtitleText(
                            text,
                            fontSize: s,
                            color: textColor,
                            weight: FontWeight.w500,
                          ),
                        ],
                      )
            : child!,
      ),
    );
  }
}

class DButton extends StatelessWidget {
  DButton({
    Key? key,
    // required this.onTap,
    this.h = 45,
    this.w = double.infinity,
    this.r = 7,
    this.s = 13,
    this.text = '',
    this.color = AppLightColors.primaryColor,
    this.textColor = Colors.white,
    this.icon,
    this.iconSize = 30,
    this.alignment = MainAxisAlignment.start,
    this.borderColor,
    this.padding = 0,
  }) : super(key: key);
  // final void Function() onTap;
  double h;
  double w;
  double r;
  double s;
  Color color;
  String text;
  Color textColor;
  IconData? icon;
  double iconSize;
  MainAxisAlignment alignment;
  Color? borderColor;
  double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: getRes(context, padding),
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.6),
        border: Border.all(
          color: borderColor ?? color,
        ),
        borderRadius: BorderRadius.circular(r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: shadowTextThemeColor,
            blurRadius: 20,
          )
        ],
      ),
      child: text != '' && icon == null
          ? SubtitleText(
              text,
              weight: FontWeight.w500,
              color: textColor,
              fontSize: s,
            )
          : text == '' && icon != null
              ? Align(
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: iconSize,
                    color: textColor,
                  ),
                )
              : Row(
                  mainAxisAlignment: alignment,
                  children: [
                    Icon(
                      icon,
                      size: iconSize,
                      color: textColor,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    SubtitleText(
                      text,
                      fontSize: s,
                      color: textColor,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
    );
  }
}
