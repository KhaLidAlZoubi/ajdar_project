import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/account_settings_page/sections/account_info.dart';
import 'package:ajder_project/ajdar_app/ui/pages/account_settings_page/sections/account_status.dart';
import 'package:ajder_project/ajdar_app/ui/pages/account_settings_page/sections/account_user_ads.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/dotter_border.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../profile_page/sections/ads_user_section.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is UpdatePhoneSuccess) {
          CustomSnackbar.show(
            context: context,
            message: "تم تحديث رقم الهاتف بنجاح",
            type: SnackbarType.success,
            topPosition: true,
          );
        }
        if (state is UpdatePhoneError) {
          CustomSnackbar.show(
            context: context,
            message: "حدث خطأ اثناء تحديث رقم الهاتف, ربما الاسم محجوز",
            type: SnackbarType.error,
            topPosition: true,
          );
        }
        if (state is UpdatePhoneErrorConnect) {
          CustomSnackbar.show(
            context: context,
            message:
                "حدث خطأ اثناء تحديث رقم الهاتف, تحقق من الاتصال في الشبكة",
            type: SnackbarType.error,
            topPosition: true,
          );
        }
        if (state is UpdateUserSuccess) {
          CustomSnackbar.show(
            context: context,
            message: "تم تحديث اسم المستخدم بنجاح",
            type: SnackbarType.success,
            topPosition: true,
          );
        }
        if (state is UpdateUserError) {
          CustomSnackbar.show(
            context: context,
            message: "حدث خطأ اثناء تحديث اسم المستخدم, ربما الاسم محجوز",
            type: SnackbarType.error,
            topPosition: true,
          );
        }
        if (state is UpdateUserErrorConnect) {
          CustomSnackbar.show(
            context: context,
            message:
                "حدث خطأ اثناء تحديث اسم المستخدم, تحقق من الاتصال في الشبكة",
            type: SnackbarType.error,
            topPosition: true,
          );
        }
        // TODO: implement listener
      },

      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  'اعدادات الحساب',
                  style: TextStyle(fontSize: getRes(context, 16)),
                ),
              ),
              body: cubit.meLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blue[50]!, Colors.purple[50]!],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(getRes(context, 10)),
                        child: ListView(
                          padding: EdgeInsets.all(getRes(context, 10)),
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: getRes(context, 40),
                                      width: getRes(context, 40),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.indigo,
                                            Colors.purple,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.settings_outlined,
                                        color: Colors.white,
                                        size: getRes(context, 22),
                                      ),
                                    ),
                                    SizedBox(width: getRes(context, 10)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleText(
                                          'إعدادات الحساب',
                                          fontSize: 16,
                                        ),
                                        SizedBox(height: getRes(context, 3)),
                                        DescriptionText(
                                          'عرض وإدارة تفاصيل حسابك الشخصي',
                                          fontSize: 14,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            AccountInfo(),
                            AccountStatus(),
                            AccountUserAds(),
                          ],
                        ),
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
