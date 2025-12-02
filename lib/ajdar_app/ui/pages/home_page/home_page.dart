// import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/services/notification_services.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/home_page/sections/for_you_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/home_page/sections/info_section.dart';
// import 'package:ajder_project/ajdar_app/ui/pages/home_page/sections/browser_more_section.dart';
// import 'package:ajder_project/ajdar_app/ui/pages/home_page/sections/for_you_section.dart';
// import 'package:ajder_project/ajdar_app/ui/pages/home_page/sections/home_header_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/home_page/sections/sections_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/notification_page/notification_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/ads_item_widget.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/app_circle_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_text_field.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../conest.dart';

// import 'sections/header_home_section.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    // required this.signalR,
  });
  // final SignalRService signalR;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchCtrl = TextEditingController();
  @override
  void initState() {
    HomeCubit cubit = HomeCubit.get(context);
    cubit.searchSections('');
    searchCtrl.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          // appBar: AppBar(
          //   leadingWidth: getRes(context, 40),
          //   toolbarHeight: getRes(context, 80),
          //   backgroundColor: backgroundContainer,
          //   title: Row(
          //     children: [
          //       Text(
          //         'سوق ',
          //         style: TextStyle(
          //             fontSize: getRes(context, 14),
          //             fontWeight: FontWeight.bold,
          //             color: AppLightColors.primaryColor),
          //       ),
          //       Text(
          //         'سوريا',
          //         style: TextStyle(
          //             fontSize: getRes(context, 14),
          //             fontWeight: FontWeight.bold,
          //             color: Colors.green),
          //       ),
          //       Text(
          //         ' المفتوح',
          //         style: TextStyle(
          //             fontSize: getRes(context, 14),
          //             fontWeight: FontWeight.bold,
          //             color: AppLightColors.primaryColor),
          //       ),
          //     ],
          //   ),
          //   leading: Image.asset('assets/icons/app/appp.png'),
          //   actions: [
          //     AppCircleButton(
          //       onTap: () {},
          //       child: Icon(
          //         Icons.favorite,
          //         color: Colors.red,
          //       ),
          //       paddingLR: 5,
          //     ),
          //     AppCircleButton(
          //       onTap: () {},
          //       child: Icon(Icons.notifications),
          //       paddingLR: 5,
          //     ),
          //     TextButton(
          //       style: ButtonStyle(
          //         // padding: WidgetStatePropertyAll(
          //         // EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          //         // ),
          //         // shape: WidgetStatePropertyAll(OutlinedBorder()),
          //         backgroundColor: WidgetStatePropertyAll(Colors.teal[400]),
          //         foregroundColor: WidgetStatePropertyAll(Colors.white),
          //       ),
          //       onPressed: () {
          //         if (box.read('token') != null) {
          //           cubit.selectPage(2);
          //         } else {
          //           showLoginDialog(context);
          //         }
          //       },
          //       child: Text(
          //         'اضافة اعلان',
          //         style: TextStyle(fontSize: getRes(context, 10)),
          //       ),
          //     ),
          //     SizedBox(
          //       width: getRes(context, 11),
          //     )
          //   ],
          // ),

          // floatingActionButton: FloatingActionButton.extended(
          //   label: Text(
          //     'اضف اعلان',
          //     style: TextStyle(
          //       fontFamily: 'Cairo-Reg',
          //     ),
          //   ),
          //   onPressed: () {},
          //   icon: Icon(Icons.add),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: getRes(context, 80),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [ShadowTheme().switchThemeShadow],
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/app/appp.png'),
                      SizedBox(height: getRes(context, 10)),
                      Row(
                        children: [
                          Text(
                            'سوق ',
                            style: TextStyle(
                              fontSize: getRes(context, 13),
                              fontWeight: FontWeight.bold,
                              color: AppLightColors.primaryColor,
                            ),
                          ),
                          Text(
                            'سوريا',
                            style: TextStyle(
                              fontSize: getRes(context, 13),
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            ' المفتوح',
                            style: TextStyle(
                              fontSize: getRes(context, 13),
                              fontWeight: FontWeight.bold,
                              color: AppLightColors.primaryColor,
                            ),
                          ),
                          // Text(
                          //   'سوق ',
                          //   style: TextStyle(
                          //       fontSize: getRes(context, 14),
                          //       fontWeight: FontWeight.bold,
                          //       color: AppLightColors.primaryColor),
                          // ),
                          // Text(
                          //   'سوريا',
                          //   style: TextStyle(
                          //       fontSize: getRes(context, 14),
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.green),
                          // ),
                          // Text(
                          //   ' المفتوح',
                          //   style: TextStyle(
                          //       fontSize: getRes(context, 14),
                          //       fontWeight: FontWeight.bold,
                          //       color: AppLightColors.primaryColor),
                          // ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          AppCircleButton(
                            onTap: () {
                              cubit.selectPage(3);
                            },
                            child: Icon(Icons.favorite, color: Colors.red),
                            paddingLR: 5,
                          ),
                          AppCircleButton(
                            onTap: () async {
                              // Navigator.push(
                              //   context,
                              //   CustomPageTransition.createRoute(
                              //     page: NotificationPage(),
                              //     isHeroStyle: true,
                              //   ),
                              // );
                              // await widget.signalR.sendAllUsersNotification(
                              //   "إشعار تجريبي 🎉",
                              //   "هذا إشعار تم إرساله من Flutter",
                              // );
                            },
                            child: Icon(Icons.notifications),
                            paddingLR: 5,
                          ),
                          InkWell(
                            onTap: () {
                              if (box.read('token') != null) {
                                cubit.selectPage(2);
                              } else {
                                showLoginDialog(context);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: getRes(context, 10),
                                vertical: getRes(context, 10),
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.green, Colors.teal],
                                ),
                                borderRadius: BorderRadius.circular(
                                  getRes(context, 25),
                                ),
                              ),
                              child: Text(
                                'اضافة اعلان',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: getRes(context, 11)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getRes(context, 15)),
                Expanded(
                  child: ListView(
                    children: [
                      cubit.sliderData.isEmpty ? Container() : SliderSection(),
                      // HomeHeaderSection(),

                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       left: getRes(context, 5),
                      //       right: getRes(context, 5),
                      //       top: getRes(context, 10),
                      //       bottom: getRes(context, 5)),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: MyTextField(
                      //           hint: 'ابحث هنا',
                      //           controller: searchCtrl,
                      //           onChanged: (value) {
                      //             cubit.searchSections(value);
                      //           },
                      //           suffix: cubit.searching
                      //               ? Padding(
                      //                   padding: EdgeInsets.symmetric(
                      //                       vertical: getRes(context, 10),
                      //                       horizontal: getRes(context, 10)),
                      //                   child: const SizedBox(
                      //                     height: 15,
                      //                     width: 15,
                      //                     child:
                      //                         CircularProgressIndicator(strokeWidth: 2),
                      //                   ),
                      //                 )
                      //               : SizedBox.shrink(),
                      //           label: '',
                      //           preIcon: Icon(EneftyIcons.search_normal_2_outline),
                      //         ),
                      //       ),
                      //       // SizedBox(width: cubit.searching ? getRes(context, 8) : 0),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: getRes(context, 15)),
                      SectionsSection(),
                      SizedBox(height: getRes(context, 40)),
                      // InfoSection()
                      // BrowserMoreSection(),
                      // ForYouSection()
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
