import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../design/colors/app_colors.dart';

class SmallText extends StatelessWidget {
  SmallText(
    this.text, {
    super.key,
    this.fontSize = 11,
    this.weight = FontWeight.w400,
    this.line,
    this.letter,
    this.overflow,
  });
  String text;
  double fontSize;
  FontWeight weight;
  int? line;
  TextOverflow? overflow;
  double? letter;
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
        letterSpacing: letter,
        color: bodyTextThemeColor,
      ),
    );
  }
}
