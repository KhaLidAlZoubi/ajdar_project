// ignore_for_file: must_be_immutable

import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/sign_up_page/sections/form_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/sign_up_page/sections/sign_in_option.dart';
import 'package:ajder_project/ajdar_app/ui/pages/privacy_policy/privacy_policy.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../design/colors/app_colors.dart';
import '../../../../widgets/custom_widgets/description_text.dart';

class BodySection extends StatefulWidget {
  BodySection({super.key, required this.login, required this.signUp});
  VoidCallback login;
  VoidCallback signUp;

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  bool isAgree = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Container(
          padding: EdgeInsets.only(
            top: getRes(context, 20),
            bottom: getRes(context, 20),
            // left: getRes(context, 10),
            // right: getRes(context, 10),
          ),
          decoration: BoxDecoration(
              // color: Colors.white,
              // borderRadius: BorderRadius.circular(getRes(context, 10)),
              // border: Border.all(color: Colors.grey[200]!),
              ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  cubit.getImage(source: ImageSource.gallery);
                },
                borderRadius: BorderRadius.circular(getRes(context, 40)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: getRes(context, 80),
                      width: getRes(context, 80),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.green[400]!,
                            Colors.teal[400]!,
                            Colors.blue,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: getRes(context, 76),
                      width: getRes(context, 76),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: getRes(context, 72),
                      width: getRes(context, 72),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                        image: cubit.imageFile != null
                            ? DecorationImage(
                                image: FileImage(cubit.imageFile!))
                            : null,
                        // border: Border.all(color: Colors.grey[400]!),
                      ),
                      child: cubit.imageFile != null
                          ? null
                          : Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: getRes(context, 32),
                            ),
                    ),
                    Positioned(
                      bottom: getRes(context, 3),
                      right: getRes(context, 3),
                      child: Container(
                        height: getRes(context, 26),
                        width: getRes(context, 26),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.green[400]!,
                                Colors.teal[400]!,
                                Colors.blue,
                              ],
                            )),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: getRes(context, 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              FormSection(),
              SizedBox(height: AppDimensions.h5(context)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getRes(context, 15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: getRes(context, 30),
                      width: getRes(context, 30),
                      child: Checkbox(
                          value: isAgree,
                          onChanged: (value) {
                            setState(() {
                              isAgree = value!;
                            });
                          }),
                    ),
                    SizedBox(
                      width: getRes(context, 10),
                    ),
                    Text('انت موافق على'),
                    //  SizedBox(
                    //   width: getRes(context, 10),
                    // ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CustomPageTransition.createRoute(
                              page: PrivacyPolicy(),
                              isHeroStyle: true,
                            ),
                          );
                        },
                        child: Text('سياسة الخصوصية'))
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.h10(context)),
              state is AuthRegisterLoadingState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: getRes(context, 30)),
                      child: AuthCubit.get(context).isEnablePhoneRegister ==
                                  false ||
                              AuthCubit.get(context).isEnableName == false ||
                              AuthCubit.get(context).isEnableEmail == false ||
                              AuthCubit.get(context).isEnablePassword ==
                                  false ||
                              isAgree == false
                          ? DisableContainer(
                              text: S.of(context).next,
                            )
                          : InkWell(
                              onTap: widget.signUp,
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
                                  'التالي',
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
              SizedBox(
                height: getRes(context, 20),
              ),
              SignInOption(
                login: widget.login,
              ),
            ],
          ),
        );
      },
    );
  }
}

class DisableContainer extends StatelessWidget {
  DisableContainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getRes(context, 42),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green[400]!.withOpacity(.7),
            Colors.teal[400]!.withOpacity(.7),
            Colors.blue.withOpacity(.7),
          ],
        ),
        borderRadius: BorderRadius.circular(
          getRes(context, 15),
        ),
        // color: AppLightColors.primaryColor.withOpacity(.7),
      ),
      child: DescriptionText(
        text,
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }
}
