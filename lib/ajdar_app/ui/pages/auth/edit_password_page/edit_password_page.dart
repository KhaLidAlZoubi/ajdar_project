import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/edit_password_page/sections/body_forget_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/edit_password_page/sections/header_forget_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/login_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          Navigator.push(
            context,
            CustomPageTransition.createRoute(page: LoginPage(), isBack: true),
          );
          CustomSnackbar.show(
            context: context,
            message:
                "الحساب موجود, تم ارسال رابط تحقق الى البريد الالكتروني: ${AuthCubit.get(context).emailForgetCtrl.text}",
            type: SnackbarType.success,
          );
          AuthCubit.get(context).emailForgetCtrl.clear();
        }
        if (state is ForgetPasswordError) {
          CustomSnackbar.show(
            context: context,
            message: "حدث خطأ ربما الحساب غير موجود, حاول مجددا",
            type: SnackbarType.error,
          );
        }
        if (state is ForgetPasswordErrorConnect) {
          CustomSnackbar.show(
            context: context,
            message: "حدث خطأ في الاتصال, حاول مجددا",
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return Scaffold(
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  HeaderForgetSection(text: "ادخل بريدك الالكتروني"),
                  BodyForgetSection(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
