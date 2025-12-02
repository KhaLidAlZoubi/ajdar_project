import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../confirm/theme/sub_theme_data.dart';
import '../../design/colors/app_colors.dart';

class BigText extends StatelessWidget {
  BigText(
    this.text, {
    super.key,
    required this.fontSize,
    this.weight = FontWeight.bold,
  });
  String text;
  double fontSize;
  FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: getRes(context, fontSize),
        fontWeight: weight,
        color: titleTextThemeColor,
      ),
    );
  }
}
