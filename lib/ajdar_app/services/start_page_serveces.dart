import 'package:ajder_project/ajdar_app/ui/layout/home/home_layout.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/login_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/otp_page/otp_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/onboardin_page/onboarding_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/material.dart';

import '../domain/home_cubit/home_cubit.dart';

class StartPage {
  String _authKey = 'completeAuth';
  String _boardingKey = 'completeBoarding';
  String _tokenKey = 'token';
  String _completeUserKey = 'completeUserKey';
  _saveData(String key, bool complete) => box.write(key, complete);
  _saveToken(String token) => box.write(_tokenKey, token);
  bool get _readBoardingFromBox => box.read(_boardingKey) ?? false;
  get _readToken => box.read(_tokenKey);
  bool get _readCompleteUserData => box.read(_completeUserKey) ?? false;
  bool get _readAuthFromBox => box.read(_authKey) ?? false;
  Widget get startPage =>
      _readBoardingFromBox ? HomeUserLayout() : OnboardingPage();
  submitOnboarding(context) {
    _saveData(_boardingKey, !_readBoardingFromBox);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  submitRegister(context) {
    _saveData(_authKey, !_readAuthFromBox);
    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));
  }

  submitToken(context, String token, String refreshToken) {
    _saveToken(token);
    box.write('refreshToken', refreshToken);
    HomeCubit.get(context).getProfileConnect();
    Navigator.pushAndRemoveUntil(
      context,
      CustomPageTransition.createRoute(
        page: HomeUserLayout(),
        isHeroStyle: true,
      ),
      (route) => false,
    );
  }

  // submitCompleteUserData(context) {
  //   _saveData(_completeUserKey, !_readCompleteUserData);
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => ContractPage()
  //           //  HomeUserLayout(),
  //           ),
  //       (route) => false);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     customSnackBar(
  //       context,
  //       title: 'تسجيل الحساب',
  //       message: 'تم اكمال المعلومات بنجاح',
  //       backgroundColor: AppLightColors.successColor,
  //     ),
  //   );
  // }
}
