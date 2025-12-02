import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
import 'package:ajder_project/ajdar_app/ui/layout/home/home_layout.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/help_center/help_auth_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';

class HeaderForgetSection extends StatelessWidget {
  HeaderForgetSection({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [ShadowTheme().switchThemeShadow],
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
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeUserLayout();
                      },
                    ),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.close),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: HelpAuthPage(),
                      isHeroStyle: true,
                    ),
                  );
                },
                child: Text(
                  'مساعدة',
                  style: TextStyle(fontFamily: 'Cairo-Reg'),
                ),
              ),
            ],
          ),
          TitleText(
            'نسيان كلمة المرور',
            fontSize: 20,
            // style: titleSmallStyle(context),
          ),
          SizedBox(height: getRes(context, 10)),
          DescriptionText("$text", fontSize: 15),
        ],
      ),
    );
  }
}
