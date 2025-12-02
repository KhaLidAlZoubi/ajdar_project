import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme with SubThemeData {
  ThemeData get buildLightTheme => ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: AppLightColors.primaryColor,
      useMaterial3: true,
      textTheme: GoogleFonts.cairoTextTheme(),
      scaffoldBackgroundColor: Color(0xFFfafcff),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFfafcff),
      ));
}
