// ignore_for_file: must_be_immutable

import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../design/colors/app_colors.dart';
import '../../../../widgets/custom_widgets/subtitle_text.dart';

class SignInOption extends StatelessWidget {
  SignInOption({super.key, required this.login});
  VoidCallback login;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SubtitleText(
          S.of(context).account,
          fontSize: 14,
          color: Colors.grey,
          // style: descriptionStyle(context),
        ),
        TextButton(
          onPressed: login,
          child: Text(
            S.of(context).loginTile,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              color: AppLightColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
