import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/login_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../confirm/theme/shadow_theme.dart';
import '../../../../domain/home_cubit/home_cubit.dart';
import '../../../design/dimensions/app_dimensions.dart';
import '../../../widgets/custom_widgets/ads_item_widget.dart';
import '../../../widgets/custom_widgets/app_circle_button.dart';
import '../../../widgets/custom_widgets/subtitle_text.dart';
import '../sections_selection_page/sections_selections_page.dart';

class AddAdsPage extends StatelessWidget {
  const AddAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return HomeCubit.get(context).token == ''
            ? LoginPage()
            : Scaffold(
                appBar: AppBar(
                  leadingWidth: getRes(context, 40),
                  toolbarHeight: getRes(context, 80),
                  backgroundColor: backgroundContainer,
                  title: Row(
                    children: [
                      Text(
                        'سوق ',
                        style: TextStyle(
                            fontSize: getRes(context, 14),
                            fontWeight: FontWeight.bold,
                            color: AppLightColors.primaryColor),
                      ),
                      Text(
                        'سوريا',
                        style: TextStyle(
                            fontSize: getRes(context, 14),
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Text(
                        ' المفتوح',
                        style: TextStyle(
                            fontSize: getRes(context, 14),
                            fontWeight: FontWeight.bold,
                            color: AppLightColors.primaryColor),
                      ),
                    ],
                  ),
                  leading: Image.asset('assets/icons/app/appp.png'),
                  actions: [
                    AppCircleButton(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      paddingLR: 5,
                    ),
                    AppCircleButton(
                      onTap: () {},
                      child: Icon(Icons.notifications),
                      paddingLR: 5,
                    ),
                    SizedBox(
                      width: getRes(context, 11),
                    )
                  ],
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText('اضافة اعلان'),
                    SizedBox(
                      height: getRes(context, 10),
                    ),
                    SubtitleText(
                        'بيع ما تشاء, اضف اعلاناتك من هنا الان لتظهر لجميع'),
                    SizedBox(
                      height: getRes(context, 10),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: getRes(context, 20)),
                      child: Image.asset('assets/images/add_ads.png'),
                    ),
                    SizedBox(
                      height: getRes(context, 20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CustomPageTransition.createRoute(
                                page: SectionsSelectionsPage(), isModal: true));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: getRes(context, 30)),
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
                          borderRadius:
                              BorderRadius.circular(getRes(context, 15)),
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
                ),
              );
      },
    );
  }
}
