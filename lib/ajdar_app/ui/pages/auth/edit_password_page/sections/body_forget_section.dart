import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyForgetSection extends StatelessWidget {
  const BodyForgetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Padding(
          padding: EdgeInsets.all(getRes(context, 15)),
          child: Column(
            children: [
              SizedBox(height: getRes(context, 20)),
              MyTextField(
                hint: "ادخل البريد الالكتروني",
                controller: cubit.emailForgetCtrl,
                type: TextInputType.emailAddress,
                label: "البريد الالكتروني",
                onChanged: (String value) {
                  AuthCubit.get(context).enableForgetEmailValue(value);
                },
                error: AuthCubit.get(context).isErrorForgetEmail == true
                    ? 'ادخل بريد الكتروني صحيح'
                    : null,
                border: AuthCubit.get(context).isErrorForgetEmail == true
                    ? Border.all(color: Colors.red, width: 1.3)
                    : null,
              ),
              SizedBox(height: getRes(context, 30)),
              if (!cubit.isEnableForgetEmail)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getRes(context, 20),
                  ),
                  child: DButton(text: 'تأكيد'),
                )
              else
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getRes(context, 20),
                  ),
                  child: DefaultButton(
                    onTap: () {
                      if (!cubit.forgetPasswordLoading) {
                        cubit.forgetPassword();
                      }
                    },
                    text: 'تأكيد',
                    child: cubit.forgetPasswordLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
