import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitleText extends StatelessWidget {
  SubtitleText(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.weight = FontWeight.w500,
    this.color,
    this.decoration,
    this.decorationThickness,
    this.decorationColor,
    this.maxLines,
    this.align,
  });
  String text;
  double fontSize;
  FontWeight weight;
  TextDecoration? decoration;
  double? decorationThickness;
  Color? decorationColor;
  Color? color;
  int? maxLines;
  TextAlign? align;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'Cairo',
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
        fontSize: getRes(context, fontSize),
        fontWeight: weight,
        color: color ?? titleTextThemeColor,
      ),
    );
  }
}
