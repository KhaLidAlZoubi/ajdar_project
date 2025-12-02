import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  IconText({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor = AppLightColors.primaryColor,
  });
  String text;
  IconData icon;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getRes(context, 10), vertical: getRes(context, 6)),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(getRes(context, 10))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: getRes(context, 14),
          ),
          SizedBox(
            width: getRes(context, 5),
          ),
          SmallText(text)
        ],
      ),
    );
  }
}
