import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  NoData({super.key, this.height, this.width});
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText('القسم قارغ'),
        SizedBox(
          height: getRes(context, 10),
        ),
        SubtitleText('لا يوجد اعلانات هنا حتى الان'),
        SizedBox(
          height: getRes(context, 10),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: getRes(context, 20)),
          width: width,
          height: height,
          child: Image.asset('assets/images/no_no.jpg'),
        ),
      ],
    );
  }
}
