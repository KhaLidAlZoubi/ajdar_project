import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ui/design/colors/app_dark_color.dart';

class DarkTheme with SubThemeData {
  ThemeData get buildDarkTheme => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Color(0xFF3F3FE0),
        useMaterial3: true,
        textTheme: GoogleFonts.cairoTextTheme(),
        scaffoldBackgroundColor: Color.fromARGB(255, 18, 22, 29),
        shadowColor: AppDarkColor.shadowColor,
      );
}
