import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/componets/image_background_container.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

class ServiceShortComponents extends StatelessWidget {
  ServiceShortComponents({
    super.key,
    required this.text,
    this.img,
    this.rate,
  });
  final String text;
  String? img;
  String? rate;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getRes(context, 33),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 225, 225, 240),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(
            getRes(context, 17),
          ),
          left: Radius.circular(getRes(context, 10)),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageBackgroundContainer(
            height: 28,
            width: 28,
            url: img,
            radius: 14,
            child: img == null
                ? Icon(
                    Icons.home,
                    color: AppLightColors.primaryColor,
                    size: getRes(context, 15),
                  )
                : null,
          ),
          SizedBox(
            width: getRes(context, 5),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getRes(context, 6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubtitleText(
                  text,
                  fontSize: 9,
                  weight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Icon(
                      EneftyIcons.star_bold,
                      color: Colors.orange,
                      size: getRes(context, 10),
                    ),
                    SizedBox(
                      height: getRes(context, 1.5),
                    ),
                    SmallText(
                      ' 4.5',
                      fontSize: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
