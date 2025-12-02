import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_dark_color.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin SubThemeData {
  TextTheme getTextTheme(context) => GoogleFonts.cairoTextTheme(
        TextTheme(
          headlineLarge: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            color: AppLightColors.titleTextColor,
            fontSize: getRes(context, 24),
          ),
        ),
      );
}
ColorScheme colorScheme(BuildContext context) => Theme.of(context).colorScheme;
bool isDark = box.read('isDark') ?? false;
Color get titleTextThemeColor => box.read('isDark') == true
    ? AppDarkColor.titleColor
    : AppLightColors.titleTextColor;
Color get bodyTextThemeColor => box.read('isDark') == true
    ? AppDarkColor.bodyColor
    : AppLightColors.bodyColor;
Color get backgroundContainer =>
    box.read('isDark') == true ? AppDarkColor.containerColor : Colors.white;
Color get backgroundIcon =>
    box.read('isDark') == true ? Color(0xFF364560) : Color(0xFFEAF0FE);
Color get shadowTextThemeColor =>
    box.read('isDark') == true ? Color(0xA613151C) : AppLightColors.shadowColor;
