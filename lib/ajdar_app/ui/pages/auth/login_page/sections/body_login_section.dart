// ignore_for_file: must_be_immutable
import 'dart:convert';

import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/edit_password_page/edit_password_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/sign_up_page/sections/body_sign_up_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/edit_password/edit_password.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_text_field.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../../../../../../generated/l10n.dart';
import '../../../../../domain/home_cubit/home_cubit.dart';
import '../../../../../services/start_page_serveces.dart';

class BodyLoginSection extends StatefulWidget {
  BodyLoginSection({
    super.key,
    required this.login,
    required this.createAccount,
  });
  VoidCallback login;
  VoidCallback createAccount;

  @override
  State<BodyLoginSection> createState() => _BodyLoginSectionState();
}

class _BodyLoginSectionState extends State<BodyLoginSection> {
  String? _errorMessage;
  BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // final authService = AuthService();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getRes(context, 15)),
          child: Column(
            children: [
              MyTextField(
                controller: AuthCubit.get(context).phoneLogin,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                onChanged: (String value) {
                  // AuthCubit.get(context).enablePhoneLoginValue(value);
                },
                type: TextInputType.emailAddress,
                // suffix: RotatedBox(
                //   quarterTurns: 4,
                //   child: Icon(
                //     Icons.phone_outlined,
                //     color: AppLightColors.primaryColor,
                //   ),
                // ),
                label: 'البريد الالكتروني',
                border: AuthCubit.get(context).isErrorPhone == true
                    ? Border.all(color: Colors.red, width: 1.3)
                    : null,
                error: AuthCubit.get(context).isErrorPhone == true
                    ? S.of(context).phoneValidate
                    : null,

                preIcon: Icon(Icons.email, color: Colors.teal),
                hint: 'example@gmail.com',
                // border: Border.all(color: Colors.red),
              ),
              MyTextField(
                controller: AuthCubit.get(context).passwordLogin,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                obscure: AuthCubit.get(context).obscure,
                onChanged: (String value) {
                  // AuthCubit.get(context).enablePhoneLoginValue(value);
                },
                type: TextInputType.visiblePassword,
                lines: 1,
                label: 'كلمة المرور',

                preIcon: Icon(Icons.lock, color: Colors.teal),
                suffix: IconButton(
                  onPressed: () {
                    AuthCubit.get(context).sw();
                  },
                  icon: Icon(
                    AuthCubit.get(context).obscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: bodyTextThemeColor,
                  ),
                ),

                hint: '********',
                // border: Border.all(color: Colors.red),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomPageTransition.createRoute(
                        page: EditPasswordPage(),
                        isBack: true,
                      ),
                    );
                  },
                  child: Text('هل نسيت كلمة المرور؟'),
                ),
              ),
              SizedBox(height: getRes(context, 10)),
              state is AuthLoginLoadingState
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getRes(context, 30),
                      ),
                      child:
                          //  AuthCubit.get(context).isEnablePhone == false
                          //     ? DisableContainer(text: S.of(context).loginTile)
                          //     :
                          InkWell(
                            onTap: () {
                              AuthCubit.get(context).loginConnect();
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
                                S.of(context).loginTile,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                    ),
              SizedBox(height: AppDimensions.h25(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SubtitleText(
                    S.of(context).noAccount,
                    fontSize: 14,
                    color: Colors.grey,
                    // style: descriptionStyle(context),
                  ),
                  TextButton(
                    onPressed: widget.createAccount,
                    child: Text(
                      S.of(context).createAccount,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        color: AppLightColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getRes(context, 20)),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   spacing: getRes(context, 20),
              //   children: [
              //     InkWell(
              //       onTap: () async {
              //         final user = await signInWithGoogle();
              //         if (user != null) {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text('أهلا ${user.displayName}')),
              //           );
              //         }
              //       },
              //       borderRadius: BorderRadius.circular(getRes(context, 15)),
              //       child: CircleAvatar(
              //         radius: 18,
              //         child: _isLoading
              //             ? Container(
              //                 height: getRes(context, 20),
              //                 width: getRes(context, 20),
              //                 child: Center(child: CircularProgressIndicator()),
              //               )
              //             : Image.asset(
              //                 'assets/icons/google.png',
              //                 height: getRes(context, 30),
              //                 width: getRes(context, 30),
              //               ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: CircleAvatar(
              //         radius: 18,
              //         child: Icon(Icons.facebook),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }

  bool _isLoading = false;
  Future<GoogleSignInAccount?> signInWithGoogl() async {
    try {
      // تسجيل الدخول كما في كودك الحالي
      final user = await GoogleSignIn.instance.authenticate();

      if (user == null) {
        debugPrint('❌ Sign in canceled');
        return null;
      }

      // الحصول على التوكن
      final auth = await user.authentication;
      final idToken = auth.idToken;

      debugPrint('✅ Signed in as: ${user.displayName} (${user.email})');
      debugPrint('🔑 ID Token: $idToken');

      // هنا نرسل التوكن للـ API الخاص بك
      // await sendTokenToApi(idToken, user.email, user.displayName);

      return user;
    } on GoogleSignInException catch (e) {
      debugPrint('❌ Google Sign In failed: ${e.code} - ${e.description}');
      return null;
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      return null;
    }
  }

  /// تابع لإرسال التوكن للـ API
  Future<void> sendTokenToApi(
    String? idToken,
    String? email,
    String? name,
  ) async {
    if (idToken == null) return;
    print("idToken: $idToken");

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ${box.read('token')}',
      // 'lang': box.read('lang')
    };

    try {
      var request = http.Request(
        'POST',
        Uri.parse('https://api.syriaopenstore.com/api/Auth/google-login'),
      );
      request.body = json.encode({'token': '$idToken'});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // return await request.send();

      if (response.statusCode == 200) {
        box.write('token', idToken);
        HomeCubit.get(context).token = box.read('token');
        HomeCubit.get(context).getProfileConnect();
        print(await response.stream.bytesToString());
      } else {
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      debugPrint('❌ Failed to send token: $e');
    }
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      // تهيئة GoogleSignIn (مهم خصوصًا للويب / iOS)
      await GoogleSignIn.instance.initialize(
        clientId: '$clintAndroidId', // ضع clientId للويب إن لزم
        serverClientId: '', // ضع serverClientId إذا بدك backend auth
      ); // تسجيل الدخول
      final user = await GoogleSignIn.instance.authenticate();
      if (user == null) {
        debugPrint('❌ Sign in canceled');
        return null;
      }
      debugPrint('✅ Signed in as: ${user.displayName} (${user.email})');
      debugPrint('✅ Token: ${user.authentication.idToken}');
      // await sendTokenToApi(
      // user.authentication.idToken, user.email, user.displayName);

      return user;
    } on GoogleSignInException catch (e) {
      debugPrint('❌ Google Sign In failed: ${e.code} - ${e.description}');
      return null;
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      return null;
    }
  }

  /// تسجيل الخروج
  Future<void> signOut() async {
    await GoogleSignIn.instance.disconnect();
    debugPrint('👋 Signed out');
  }
}

// import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';
