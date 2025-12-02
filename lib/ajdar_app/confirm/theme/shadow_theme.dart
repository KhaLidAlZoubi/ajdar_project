import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/material.dart';

import '../../ui/design/colors/app_dark_color.dart';

class ShadowTheme {
  BoxShadow get lightShadow => const BoxShadow(
        offset: Offset(0, 5),
        color: AppLightColors.shadowColor,
        blurRadius: 20,
      );
  BoxShadow get darkShadow => const BoxShadow(
        offset: Offset(0, 5),
        color: Color(0xA613151C),
        blurRadius: 20,
      );
  BoxShadow get switchThemeShadow =>
      box.read('isDark') == true ? darkShadow : lightShadow;
}
