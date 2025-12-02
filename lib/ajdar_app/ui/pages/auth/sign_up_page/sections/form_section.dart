import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../design/colors/app_colors.dart';
import '../../../../design/dimensions/app_dimensions.dart';

class FormSection extends StatelessWidget {
  FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          controller: AuthCubit.get(context).nameValue,
          type: TextInputType.text,
          suffix: Icon(
            Icons.person_outline,
            color: Colors.teal,
          ),
          onChanged: (value) {
            AuthCubit.get(context).enableNameValue(value);
          },
          error: AuthCubit.get(context).isErrorName == true
              ? S.of(context).nameValidate
              : null,
          border: AuthCubit.get(context).isErrorName == true
              ? Border.all(color: Colors.red, width: 1.3)
              : null,
          label: S.of(context).name,
          hint: S.of(context).nameHint,
        ),
        MyTextField(
          controller: AuthCubit.get(context).phoneValue,
          type: TextInputType.phone,
          // textAlign: TextAlign.left,
          // textDirection: TextDirection.ltr,
          onChanged: (value) {
            AuthCubit.get(context).enablePhoneRegisterValue(value);
          },
          error: AuthCubit.get(context).isErrorPhoneRegister == true
              ? 'ادخل رقم سوري يبدأ 9 ومن 9 خانات'
              : null,
          border: AuthCubit.get(context).isErrorPhoneRegister == true
              ? Border.all(color: Colors.red, width: 1.3)
              : null,
          preIcon: Icon(
            Icons.phone_outlined,
            color: Colors.teal,
          ),
          suffix: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: getRes(context, 15),
              ),
              Text(
                '+963',
                textDirection: TextDirection.ltr,
                // '+963',
                style: TextStyle(
                  fontSize: getRes(context, 14),
                ),
              ),
              SizedBox(
                width: getRes(context, 15),
              )
            ],
          ),
          hint: 'xxx-xxx-xxx',
          label: S.of(context).phone,
        ),
        MyTextField(
          controller: AuthCubit.get(context).emailCtrl,
          // textAlign: TextAlign.left,
          // textDirection: TextDirection.ltr,
          onChanged: (String value) {
            AuthCubit.get(context).enableEmailValue(value);
          },
          error: AuthCubit.get(context).isErrorEmail == true
              ? 'ادخل بريد الكتروني صحيح'
              : null,
          border: AuthCubit.get(context).isErrorEmail == true
              ? Border.all(color: Colors.red, width: 1.3)
              : null,
          type: TextInputType.emailAddress,
          // suffix: RotatedBox(
          //   quarterTurns: 4,
          //   child: Icon(
          //     Icons.phone_outlined,
          //     color: AppLightColors.primaryColor,
          //   ),
          // ),
          label: 'البريد الالكتروني',

          preIcon: Icon(
            Icons.email,
            color: Colors.teal,
          ),
          hint: 'example@gmail.com',
          // border: Border.all(color: Colors.red),
        ),
        MyTextField(
          controller: AuthCubit.get(context).passwordCtrl,
          // textAlign: TextAlign.left,
          // textDirection: TextDirection.ltr,
          onChanged: (String value) {
            AuthCubit.get(context).enablePasswordValue(value);
          },
          error: AuthCubit.get(context).isErrorPassword == true
              ? 'ادخل كلمة مرور متنوعة'
              : null,
          border: AuthCubit.get(context).isErrorPassword == true
              ? Border.all(color: Colors.red, width: 1.3)
              : null,
          type: TextInputType.visiblePassword,
          lines: 1,
          // suffix: RotatedBox(
          //   quarterTurns: 4,
          //   child: Icon(
          //     Icons.phone_outlined,
          //     color: AppLightColors.primaryColor,
          //   ),
          // ),
          label: 'كلمة المرور',

          preIcon: Icon(
            AuthCubit.get(context).obscureRe
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppLightColors.descriptionColor,
          ),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          obscure: AuthCubit.get(context).obscureRe,

          suffix: IconButton(
            onPressed: () {
              AuthCubit.get(context).swRe();
            },
            icon: Icon(
              AuthCubit.get(context).obscureRe
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: bodyTextThemeColor,
            ),
          ),

          hint: 'ادخل كلمة المرور',
          // border: Border.all(color: Colors.red),
        ),
      ],
    );
  }
}
