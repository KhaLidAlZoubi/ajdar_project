import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/data/model/me_model.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/account_settings_page/account_settings_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/chat_page/chat_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/notification_page/notification_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/privacy_policy/privacy_policy.dart';
import 'package:ajder_project/ajdar_app/ui/pages/profile_page/sections/ads_user_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/profile_page/sections/no_token_user.dart';
import 'package:ajder_project/ajdar_app/ui/pages/wishlist_page/wishlist_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/page_condition.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:ajder_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../conest.dart';
import '../../../../domain/home_cubit/home_state.dart';
import '../../../widgets/custom_widgets/custom_button.dart';
import '../../about_us_page/aboute_us_page.dart';

class ProfileBodySection extends StatelessWidget {
  ProfileBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    if (HomeCubit.get(context).token == '') {
      // return MyAdsPage();
      return NoTokenUser();
    } else {
      return MyMePage();
    }
    // return;
  }
}

class MyMePage extends StatelessWidget {
  const MyMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is DeleteSuccess) {
          // CustomSnackbar.show(context: context, message: 'تم حذف الحساب بنجاح',type: SnackbarType.success);
        }
        if (state is DeleteError) {}
        if (state is DeleteErrorConnect) {}
      },
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            return cubit.meLoading
                ? Center(child: CircularProgressIndicator())
                : pageCondition(
                    status: cubit.meStatus,
                    widget: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getRes(context, 15),
                            vertical: getRes(context, 15),
                          ),
                          child: userCard(context, model: cubit.meData!),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getRes(context, 15),
                            vertical: getRes(context, 15),
                          ),
                          child: settingsCart(
                            context,
                            userId: cubit.meData!.id!,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getRes(context, 15),
                            vertical: getRes(context, 15),
                          ),
                          child: infoCart(context),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: DefaultButton(
                            alignment: MainAxisAlignment.center,
                            onTap: () {
                              HomeCubit.get(context).clearToken();
                            },
                            text: 'تسجيل الخروج',
                            icon: Icons.logout,
                            iconSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
          },
        );
      },
    );
  }

  Widget userCard(context, {required MeModel model}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getRes(context, 20),
        horizontal: getRes(context, 15),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [ShadowTheme().switchThemeShadow],
        borderRadius: BorderRadius.circular(getRes(context, 12)),
      ),
      child: Column(
        children: [
          ImageUserSection(cubit: HomeCubit.get(context)),
          SizedBox(height: getRes(context, 15)),
          TitleText('${model.userName}'),
          SizedBox(height: getRes(context, 10)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getRes(context, 10),
              vertical: getRes(context, 5),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(getRes(context, 10)),
            ),
            child: SubtitleText('${model.id}', fontSize: 13),
          ),
          SizedBox(height: getRes(context, 10)),
          Divider(),
          Row(
            children: [
              Icon(Icons.email_outlined, color: Colors.teal),
              SizedBox(width: getRes(context, 10)),
              TitleText("${model.email!}", fontSize: 13),
              Spacer(),
              IconButton(
                onPressed: () {
                  // showEditField(context,
                  //     text: model.email!, title: 'البريد الالكتروني');
                },
                icon: Icon(
                  Icons.edit_note_rounded,
                  color: AppLightColors.bodyColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone_outlined, color: Colors.teal),
              SizedBox(width: getRes(context, 10)),
              TitleText("${model.phoneNumber!}", fontSize: 13),
              Spacer(),
              IconButton(
                onPressed: () {
                  // showEditField(context,
                  //     text: model.phoneNumber!, title: 'رقم الهاتف');
                },
                icon: Icon(
                  Icons.edit_note_rounded,
                  color: AppLightColors.bodyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget settingsCart(context, {required String userId}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getRes(context, 20),
        horizontal: getRes(context, 15),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [ShadowTheme().switchThemeShadow],
        borderRadius: BorderRadius.circular(getRes(context, 12)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: getRes(context, 30),
                width: getRes(context, 30),
                //     padding: EdgeInsets.symmetric(
                //   vertical: getRes(context, 12),
                // ),
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.green],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.miscellaneous_services,
                  size: getRes(context, 20),
                  color: Colors.white,
                ),
              ),
              SizedBox(width: getRes(context, 10)),
              TitleText('اعدادات الحساب'),
            ],
          ),
          Divider(),
          Column(
            children: [
              MyListTail(
                // selected: true,
                // titleTextStyle: TextStyle(fontSize: getRes(context, 16)),
                onTap: () {
                  // Navigator.pop(context);
                  // ScaffoldMessenger.of(context).;
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: MyAdsPage(),
                      isHeroStyle: true,
                    ),
                  );
                },
                leading: Icon(Icons.save, color: Color(0xFF333333)),
                subtitle: Text('اعلاناتي'),
              ),
              MyListTail(
                onTap: () {
                  // cubit.selectPage(3);
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: WishlistPage(),
                      isHeroStyle: true,
                    ),
                  );
                },
                leading: Icon(Icons.favorite_sharp, color: Color(0xFF333333)),
                subtitle: Text('المفضلة'),
              ),
              MyListTail(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: AccountSettingsPage(),
                      isHeroStyle: true,
                    ),
                  );
                },
                leading: Icon(Icons.settings, color: Color(0xFF333333)),
                subtitle: Text('اعدادات الحساب'),
              ),
              MyListTail(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: ChatPage(
                        otherUserId: "", // 🔹 ضع هنا id المسؤول
                        currentUserId:
                            "$userId", // 🔹 ضع هنا id المستخدم الحالي
                      ),
                      isHeroStyle: true,
                    ),
                  );
                  //                   final messagesService = MessagesService(
                  //   baseUrl: 'https://api.syriaopenstore.com',
                  //   getToken: () async {
                  //     return 'Bearer ${box.read("token")}'; // حسب تخزينك للتوكن
                  //   },
                  // );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ChatPage(
                  //       otherUserId: "user-guid-الطرف-الآخر",
                  //       service: messagesService,
                  //     ),
                  //   ),
                  // );
                },
                leading: Icon(
                  Icons.miscellaneous_services,
                  color: Color(0xFF333333),
                ),
                subtitle: Text('الدعم الفني'),
              ),
              MyListTail(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: NotificationPage(),
                      isHeroStyle: true,
                    ),
                  );
                },
                leading: Icon(Icons.notifications, color: Color(0xFF333333)),
                subtitle: Text('الاشعارات'),
              ),
              // MyListTail(
              //   onTap: () {
              //     _showDeleteDialog(context);
              //   },
              //   leading: Icon(Icons.delete_forever, color: Colors.red[800]),
              //   subtitle: Text(
              //     'حذف الحساب',
              //     style: TextStyle(
              //       color: Colors.red[800],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white, // ✅ لون الخلفية أبيض
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getRes(context, 10),
          ), // ✅ انحناء الحواف بمقدار 10
        ),
        title: Text("حذف الحساب!", style: TextStyle(fontFamily: 'Cairo-Reg')),
        content: Text(
          "يؤدي حذف الحساب الى حذف اعلاناتك والبيانات المرتبطة",
          style: TextStyle(fontFamily: 'Cairo-Reg'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("إلغاء", style: TextStyle(fontFamily: 'Cairo-Reg')),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white, // ✅ لون الزر أحمر
              foregroundColor: AppLightColors.titleTextColor, // ✅ لون النص أبيض
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getRes(context, 10),
                ), // ✅ انحناء زر الخروج
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              HomeCubit.get(context).deleteAccount();
              // Future.delayed(const Duration(milliseconds: 300), () {
              //   SystemNavigator.pop(); // إغلاق التطبيق
              // });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red, // ✅ لون الزر أحمر
              foregroundColor: Colors.white, // ✅ لون النص أبيض
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getRes(context, 10),
                ), // ✅ انحناء زر الخروج
              ),
            ),
            child: Text("موافق", style: TextStyle(fontFamily: 'Cairo-Reg')),
          ),
        ],
      ),
    );
  }

  Widget infoCart(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getRes(context, 20),
        horizontal: getRes(context, 15),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [ShadowTheme().switchThemeShadow],
        borderRadius: BorderRadius.circular(getRes(context, 12)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: getRes(context, 30),
                width: getRes(context, 30),
                //     padding: EdgeInsets.symmetric(
                //   vertical: getRes(context, 12),
                // ),
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.green],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info,
                  size: getRes(context, 20),
                  color: Colors.white,
                ),
              ),
              SizedBox(width: getRes(context, 10)),
              TitleText('اخرى'),
            ],
          ),
          Divider(),
          Column(
            children: [
              MyListTail(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: AboutUsPage(),
                      isHeroStyle: true,
                    ),
                  );
                },
                leading: Icon(Icons.error_outline, color: Color(0xFF333333)),
                subtitle: Text('حول التطبيق'),
              ),
              MyListTail(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: PrivacyPolicy(),
                      isHeroStyle: true,
                    ),
                  );
                },
                leading: Icon(Icons.security, color: Color(0xFF333333)),
                subtitle: SubtitleText('سياسة الخصوصية'),
              ),
              // MyListTail(
              //   leading: Icon(Icons.home),
              //   title: Text('العودة للرئيسية'),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // showEditField(context, {required String text, required String title}) {
  //   final ctr = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (ctx) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         title: Text(
  //           "تعديل $title",
  //           style: TextStyle(
  //             fontSize: getRes(context, 16),
  //           ),
  //         ),
  //         content: TextField(
  //           controller: ctr,
  //           keyboardType: title == 'رقم الهاتف'
  //               ? TextInputType.phone
  //               : TextInputType.emailAddress,
  //           decoration: InputDecoration(
  //             labelText: "$title",
  //             border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(getRes(context, 15))),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(ctx); // إغلاق بدون تنفيذ
  //             },
  //             child: const Text("تراجع"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               // هنا طبق المنطق للفلترة
  //               // print("من: $min إلى: $max");

  //               Navigator.pop(ctx);
  //               HomeCubit cubit = HomeCubit.get(context);
  //               if (title == 'رقم الهاتف') {
  //                 cubit.updatePhone(ctr.text);
  //               } else {
  //                 cubit.updateUsername();
  //               }
  //             },
  //             style: ButtonStyle(
  //                 backgroundColor: WidgetStatePropertyAll(Colors.teal),
  //                 foregroundColor: WidgetStatePropertyAll(Colors.white)),
  //             child: const Text("موافق"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
