import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
// import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/otp_page/sections/otp_form_section.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../conest.dart';
import '../../../../../../generated/l10n.dart';
import '../../sign_up_page/sections/body_sign_up_section.dart';

class BodyOTPSection extends StatelessWidget {
  BodyOTPSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getRes(context, 20)),
          child: Column(
            children: [
              SubtitleText(
                "${S.of(context).otpDescription} ${box.read('email')}",
                fontSize: 12,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: getRes(context, 20),
              ),
              OTPFormSection(),
              SizedBox(
                height: getRes(context, 25),
              ),
              state is AuthVerifyLoadingState
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: getRes(context, 30)),
                      child: AuthCubit.get(context).isEnableOtp == false
                          ? DisableContainer(
                              text: S.of(context).otpTitle,
                            )
                          : InkWell(
                              onTap: () {
                                AuthCubit.get(context).verifyCodeConnect();
                              },
                              borderRadius: BorderRadius.circular(
                                getRes(context, 15),
                              ),
                              child: Container(
                                height: getRes(context, 42),
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green[400]!,
                                      Colors.teal[400]!,
                                      Colors.blue,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    getRes(context, 15),
                                  ),
                                  // color: AppLightColors.primaryColor.withOpacity(.7),
                                ),
                                child: DescriptionText(
                                  S.of(context).otpTitle,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
              SizedBox(
                height: getRes(context, 25),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DescriptionText(
                    state is AuthVerifyStartTimeState
                        ? S.of(context).recentCode
                        : S.of(context).codeValid,
                  ),
                  state is AuthVerifyStartTimeState
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getRes(context, 5),
                          ),
                          child: SubtitleText(
                            AuthCubit.get(context).time,
                            fontSize: 13,
                            color: AppLightColors.primaryColor,
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            AuthCubit.get(context).recentCode();
                          },
                          child: state is AuthRecentLoadingState
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  S.of(context).recent,
                                  style: TextStyle(
                                    fontSize: getRes(context, 13),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
