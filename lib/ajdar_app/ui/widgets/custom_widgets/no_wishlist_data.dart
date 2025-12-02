import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';

class NoWishlistData extends StatelessWidget {
  NoWishlistData({super.key, this.height, this.width});
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText('القائمة فارغة'),
        SizedBox(
          height: getRes(context, 10),
        ),
        SubtitleText('لا يوجد اعلانات مفضلة هنا حتى الان'),
        SizedBox(
          height: getRes(context, 10),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: getRes(context, 20)),
          width: width,
          height: height,
          child: Image.asset('assets/images/no_no.jpg'),
        ),
        SizedBox(
          height: getRes(context, 20),
        ),
        InkWell(
          onTap: () {
            HomeCubit.get(context).goToAds();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: getRes(context, 30)),
            height: getRes(context, 60),
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 245, 103, 150),
                  const Color.fromARGB(255, 109, 182, 241),
                  const Color.fromARGB(255, 177, 45, 201)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(getRes(context, 15)),
              boxShadow: [
                ShadowTheme().switchThemeShadow,
              ],
            ),
            child: Row(
              spacing: getRes(context, 10),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(
                  'اضف اعلاناتك من هنا',
                  color: Colors.white,
                  fontSize: 15,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
