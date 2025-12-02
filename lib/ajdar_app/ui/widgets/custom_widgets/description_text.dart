import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../confirm/theme/sub_theme_data.dart';

class DescriptionText extends StatelessWidget {
  DescriptionText(
    this.text, {
    super.key,
    this.fontSize = 12,
    this.weight = FontWeight.w400,
    this.line,
    this.letter,
    this.overflow,
    this.color,
    this.decoration,
    this.height,
  });
  String text;
  double fontSize;
  FontWeight weight;
  int? line;
  TextOverflow? overflow;
  double? letter;
  Color? color;
  TextDecoration? decoration;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: line,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: getRes(context, fontSize),
        fontWeight: weight,
        decoration: decoration,
        height: height != null ? getRes(context, height!) : height,
        letterSpacing: letter,
        color: color ?? bodyTextThemeColor,
      ),
    );
  }
}
