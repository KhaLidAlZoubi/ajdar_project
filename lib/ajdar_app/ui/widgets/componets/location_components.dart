import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationComponents extends StatelessWidget {
  const LocationComponents({
    super.key,
    this.city = '',
    this.country = '',
  });
  final String city;
  final String country;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DescriptionText(
            '       الموقع',
            fontSize: getRes(context, 14),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 23,
              ),
              SizedBox(
                width: 3,
              ),
              SubtitleText(
                '${city}, ${country}',
              ),
              SizedBox(
                width: 3,
              ),
              Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 25,
              ),
            ],
          )
        ],
      ),
    );
  }
}
