import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/model/status_model.dart';
import '../../design/dimensions/app_dimensions.dart';

class PageStatus extends StatelessWidget {
  PageStatus({
    super.key,
    required this.model,
  });
  final StatusModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(),
        Container(
          height: getRes(context, 210),
          width: getRes(context, 220),
          child: SvgPicture.asset(
            'assets/images/${model.img}.svg',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: getRes(context, 10),
        ),
        TitleText(
          model.status,
          weight: FontWeight.w500,
        ),
        SizedBox(
          height: getRes(context, 10),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: getRes(context, 40),
            width: getRes(context, 120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.refresh,
                  color: AppLightColors.primaryColor,
                ),
                SizedBox(
                  width: getRes(context, 5),
                ),
                SubtitleText(
                  'Try again',
                  color: AppLightColors.primaryColor,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
