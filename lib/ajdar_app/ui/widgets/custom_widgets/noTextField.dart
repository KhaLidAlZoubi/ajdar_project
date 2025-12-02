import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:flutter/cupertino.dart';

class NoTextField extends StatelessWidget {
  NoTextField({
    super.key,
    required this.text,
    required this.label,
    required this.suffix,
    this.noLeftPadding = false,
  });
  final String text;
  final String label;
  final Widget suffix;
  bool noLeftPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: getRes(context, 15),
        left: noLeftPadding ? 0 : getRes(context, 10),
        right: noLeftPadding ? 0 : getRes(context, 10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleText(
            label,
            fontSize: 12,
          ),
          SizedBox(
            height: getRes(context, 6),
          ),
          Container(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: getRes(context, 15),
            ),
            height: getRes(context, 51),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                getRes(context, 10),
              ),
              color: backgroundContainer,
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 4),
                  color: shadowTextThemeColor,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubtitleText(
                  text,
                  fontSize: 13,
                ),
                suffix,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
