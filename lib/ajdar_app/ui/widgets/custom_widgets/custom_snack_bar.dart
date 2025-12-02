import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

SnackBar customSnackBar(
  BuildContext context, {
  required String title,
  required String message,
  required Color backgroundColor,
  bool closeButton = false,
}) {
  return SnackBar(
    backgroundColor: backgroundColor,
    showCloseIcon: closeButton,
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    margin: EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bodyBoldStyle(context)!.apply(
            color: Colors.white,
            // fontWeightDelta: 2,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          message,
          style: subBodyStyle(context)!.apply(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
