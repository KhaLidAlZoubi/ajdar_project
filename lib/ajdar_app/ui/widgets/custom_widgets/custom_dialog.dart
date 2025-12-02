import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';

import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';

import '../../../../generated/l10n.dart';

class DialogButton {
  IconData icon;
  String text;
  VoidCallback onTap;
  DialogButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });
}

customDialog(
  BuildContext context, {
  required String title,
  required String content,
  required DialogButton dialogButton1,
  required DialogButton dialogButton2,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(content),
          SizedBox(
            height: getRes(context, 27),
          ),
          Row(children: [
            Expanded(
              child: DefaultButton(
                alignment: MainAxisAlignment.center,
                onTap: dialogButton1.onTap,
                text: dialogButton1.text,
                icon: dialogButton1.icon,
                h: getRes(context, 35),
                r: getRes(context, 15),
                iconSize: getRes(context, 16),
                color: backgroundContainer,
                borderColor: Colors.grey[200],
                textColor: titleTextThemeColor,
              ),
            ),
            SizedBox(width: getRes(context, 10)),
            Expanded(
              child: DefaultButton(
                alignment: MainAxisAlignment.center,
                onTap: dialogButton2.onTap,
                text: dialogButton2.text,
                icon: dialogButton2.icon,
                h: getRes(context, 35),
                r: getRes(context, 15),
                iconSize: getRes(context, 16),
              ),
            ),
          ]),
        ],
      ),
    ),
  );
}
