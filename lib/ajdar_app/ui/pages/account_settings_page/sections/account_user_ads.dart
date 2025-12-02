import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_widgets/description_text.dart';
import '../../../widgets/custom_widgets/subtitle_text.dart';
import '../../profile_page/sections/ads_user_section.dart';

class AccountUserAds extends StatelessWidget {
  const AccountUserAds({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(top: getRes(context, 20)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundContainer,
              boxShadow: [ShadowTheme().switchThemeShadow],
              borderRadius: BorderRadius.circular(getRes(context, 15)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: getRes(context, 12)),
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.green],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(getRes(context, 15)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bar_chart_rounded, color: Colors.white),
                      SizedBox(width: getRes(context, 10)),
                      SubtitleText(
                        'الاحصائيات والاعلانات',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getRes(context, 15)),
                // image section

                // field section
                ...[
                  UserAdsItem(
                    subText: 'احمالي الاعلانات',
                    colors: [
                      const Color.fromARGB(255, 231, 241, 248),
                      // const Color.fromARGB(255, 245, 254, 245),
                      Colors.blue[100]!,
                      // Colors.green[100]!,
                      // Colors.green[600]!
                    ],
                    icon: Icons.folder_copy_rounded,
                    text: '${cubit.meData!.totalAds}',
                    // isActive: true,
                  ),
                  UserAdsItem(
                    subText: 'الإعلانات النشطة',
                    colors: [
                      const Color.fromARGB(255, 245, 254, 245),
                      // const Color.fromARGB(255, 231, 241, 248),
                      Colors.green[100]!,
                      // Colors.blue[100]!,
                      // Colors.blue[600]!
                    ],
                    icon: Icons.check_circle_outline,
                    text: '${cubit.meData!.activeAds}',
                    // isActive: false,
                  ),
                  UserAdsItem(
                    subText: 'الإعلانات الغير النشطة',
                    colors: [
                      const Color.fromARGB(255, 255, 253, 246),
                      // const Color.fromARGB(255, 247, 242, 248),
                      Colors.amber[100]!,
                    ],
                    icon: Icons.error_outline,
                    text: '${cubit.meData!.inactiveAds}',
                    // isActive: false,
                  ),

                  // FiledEditSection(),
                  SizedBox(height: getRes(context, 10)),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserAdsItem extends StatelessWidget {
  UserAdsItem({
    super.key,
    required this.colors,
    required this.icon,
    required this.text,
    required this.subText,
  });
  final List<Color> colors;
  final IconData icon;
  final String text;
  final String subText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: getRes(context, 40),
        vertical: getRes(context, 20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getRes(context, 20),
        vertical: getRes(context, 30),
      ),
      decoration: BoxDecoration(
        color: colors[0],
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(getRes(context, 15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(getRes(context, 20)),
            decoration: BoxDecoration(
              color: colors[1],
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(
              //   getRes(context, 10),
              // ),
            ),
            child: Icon(icon, color: Colors.blue, size: 30),
          ),
          SizedBox(height: getRes(context, 15)),
          TitleText(text, fontSize: 26, color: Colors.blue),
          SizedBox(height: getRes(context, 20)),
          DescriptionText(
            subText,
            // color: isActive ? Colors.indigo : Colors.red,
          ),
        ],
      ),
    );
  }
}
