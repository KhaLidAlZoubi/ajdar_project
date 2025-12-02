// ignore_for_file: must_be_immutable

import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/services/start_page_serveces.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/sections/body_login_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/sections/header_login_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/otp_page/otp_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/sign_up_page/sign_up_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/home_cubit/home_cubit.dart';
import '../../../widgets/custom_widgets/custom_snack_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccessState) {
          StartPage().submitToken(
            context,
            state.loginData['accessToken'],
            state.loginData['refreshToken'],
          );
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              context,
              title: 'تم تسجيل الدخول بنجاح',
              message: '${state.loginData['message']}',
              backgroundColor: const Color.fromARGB(255, 76, 175, 124),
            ),
          );
        }

        if (state is AuthLoginErrorConnectState) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              context,
              closeButton: true,
              title: 'هناك مشكلة',
              message: '${state.loginConnectErrorData["message"]}',
              backgroundColor: Colors.redAccent,
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
        if (state is OtpAccount) {
          Navigator.push(
            context,
            CustomPageTransition.createRoute(page: OtpPage(), isBack: true),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(
                  // left: getRes(context, 20),
                  // right: getRes(context, 20),
                  // bottom: getRes(context, 20),
                  // top: getRes(context, 40),
                ),
                child: ListView(
                  children: [
                    HeaderLoginSection(),
                    SizedBox(height: AppDimensions.h50(context)),
                    BodyLoginSection(
                      login: () {},
                      createAccount: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
