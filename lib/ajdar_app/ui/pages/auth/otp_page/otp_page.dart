import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/services/start_page_serveces.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/layout/home/home_layout.dart';
// import 'package:ajder_project/ajdar_app/ui/pages/auth/complite_user_data_page/complite_user_data_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/otp_page/sections/body_otp_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/otp_page/sections/header_otp_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/otp_page/sections/otp_form_section.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});
  //  create: (context) => AuthCubit()..startCountdown(30),
  Map b = {
    "status": true,
    "message": "success",
    "data": {
      "user": {
        "id": 7,
        "name": "Khalid mohammed",
        "phone": "00966555123456",
        "roles": []
      },
      "token": "3|bjBtwBkzszxlxSdNUIRMbujnDIwWSnLRRzQdKmO0509444f6"
    }
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit()..startCountdown(box.read('timerSecond') ?? 120),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthVerifySuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                CustomPageTransition.createRoute(
                    page: HomeUserLayout(), isHeroStyle: true),
                (route) => false);

            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(context,
                title: S.of(context).createAccount,
                message: 'تم إنشاء حساب بنجاح',
                backgroundColor: AppLightColors.successColor));
          }

          if (state is AuthVerifyErrorConnectState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                context,
                closeButton: true,
                title: 'خطأ في الإتصال',
                message: '${state.verifyConnectErrorData["message"]}',
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          if (state is AuthVerifyErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                context,
                closeButton: true,
                title: 'خطأ في الإتصال',
                message: '${state.error}',
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          if (state is AuthRecentSuccessState) {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     CustomPageTransition.createRoute(
            //         page: HomeUserLayout(), isHeroStyle: true),
            //     (route) => false);

            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(context,
                title: 'اعادة ارسال الرمز',
                message: 'تم اعادة ارسال رمز التحقق بنجاح',
                backgroundColor: AppLightColors.successColor));
          }

          if (state is AuthRecentErrorConnectState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                context,
                closeButton: true,
                title: 'خطأ في الإتصال',
                message: '${state.errorData["message"]}',
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          if (state is AuthRecentErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                context,
                closeButton: true,
                title: 'خطأ في الإتصال',
                message: '${state.error}',
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Scaffold(
                  body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  HeaderOTPSection(),
                  SizedBox(
                    height: getRes(context, 70),
                  ),
                  BodyOTPSection()
                ],
              ));
            },
          );
        },
      ),
    );
  }
}
