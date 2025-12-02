import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/services/start_page_serveces.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/otp_page/otp_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/sign_up_page/sections/body_sign_up_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/sign_up_page/sections/header_sign_up_section.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_page/login_page.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccessState) {
          StartPage().submitRegister(context);
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              context,
              title: 'تحقق من الكود',
              message: '${state.registerData['message']}',
              backgroundColor: const Color.fromARGB(255, 76, 175, 124),
            ),
          );
        }
        if (state is AuthRegisterAccountFoundConnectState) {
          StartPage().submitRegister(context);
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              context,
              closeButton: true,
              title: 'الحساب موجود',
              message: '${state.registerConnectData["message"]}',
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }

        if (state is AuthRegisterErrorConnectState) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              context,
              closeButton: true,
              title: 'خطأ في الإتصال',
              message: '${state.registerConnectErrorData["message"]}',
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state is AuthRegisterErrorState) {
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
        if (state is ValidationImage) {
          CustomSnackbar.show(
              context: context,
              message: 'حقل الصورة مطلوب قم بادخال صورتك الشخصية',
              type: SnackbarType.warning,
              topPosition: true);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Scaffold(
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  HeaderSection(),
                  SizedBox(
                    height: getRes(context, 20),
                  ),
                  BodySection(
                    login: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                      // AuthCubit.get(context).verifyCodeConnect('558437');
                    },
                    signUp: () {
                      AuthCubit.get(context).registerConnect();
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
