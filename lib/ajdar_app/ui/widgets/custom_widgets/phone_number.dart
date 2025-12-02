import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhoneNumber extends StatelessWidget {
  PhoneNumber({super.key, required this.phone});
  String phone;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/flag.png',
            height: getRes(context, 20),
            width: getRes(context, 20),
          ),
          SizedBox(
            width: getRes(context, 6),
          ),
          DescriptionText(
            '+966',
          ),
          SizedBox(
            width: getRes(context, 6),
          ),
          DescriptionText(
            phone.replaceFirst("00966", ""),
          ),
        ],
      ),
    );
  }
}
