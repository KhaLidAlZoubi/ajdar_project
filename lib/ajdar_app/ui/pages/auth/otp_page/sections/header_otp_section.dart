import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
import 'package:ajder_project/ajdar_app/ui/pages/help_page/help_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../confirm/theme/shadow_theme.dart';

class HeaderOTPSection extends StatelessWidget {
  const HeaderOTPSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            ShadowTheme().switchThemeShadow,
          ],
        ),
        padding: EdgeInsets.only(
          left: getRes(context, 15),
          right: getRes(context, 15),
          top: getRes(context, 20),
          bottom: getRes(context, 15),
        ),
        // height: AppDimensions.thirdContainer(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomPageTransition.createRoute(
                        page: HelpPage(),
                        isHeroStyle: true,
                      ),
                    );
                  },
                  child: Text(
                    'مساعدة',
                    style: TextStyle(
                      fontFamily: 'Cairo-Reg',
                    ),
                  ),
                ),
              ],
            ),
            TitleText(
              'تأكيد الحساب',
              fontSize: 20,
              // style: titleSmallStyle(context),
            ),
            SizedBox(
              height: getRes(context, 10),
            ),
            DescriptionText(
              'ادخل الكود المرسل على البريد الالكتروني للتحقق',
              fontSize: 15,
            )
          ],
        ));
  }
}
