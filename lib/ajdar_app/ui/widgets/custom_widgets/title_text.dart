import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  TitleText(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.weight = FontWeight.bold,
    this.color,
    this.letter,
  });
  String text;
  double fontSize;
  FontWeight weight;
  Color? color;
  double? letter;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Cairo-Bold',
        letterSpacing: letter,
        fontSize: getRes(context, fontSize),
        fontWeight: weight,
        color: color ?? titleTextThemeColor,
      ),
    );
  }
}
