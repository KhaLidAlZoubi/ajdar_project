// import 'package:ajder_project/ajdar_app/Customer_service/ui/layout/customer_layout/customer_layout.dart';
// import 'package:ajder_project/ajdar_app/Customer_service/ui/pages/auth/customer_login_page/customer_login_page.dart';
// import 'package:ajder_project/ajdar_app/employee/ui/layout/home_layout.dart';
// import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
// import 'package:ajder_project/conest.dart';
// import 'package:flutter/material.dart';

// import '../../generated/l10n.dart';
// import '../ui/widgets/custom_widgets/custom_snack_bar.dart';

// class CustomerStartPage {
//   String tokenKey = 'token';
//   String roleKey = 'role';
//   _saveToken(String token) => box.write(tokenKey, token);
//   _saveRole(String role) => box.write(roleKey, role);

//   get _readToken => box.read(tokenKey);
//   get _readRole => box.read(roleKey);
//   Widget get page =>
//       _readToken == null ? CustomerLoginPage() : CustomerLayout();
//   submitLogin(context, {required String token, required String role}) {
//     _saveToken(token);
//     _saveRole(role);
//     if (_readRole == 'customer') {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CustomerLayout(),
//         ),
//         (route) => false,
//       );
//     } else {
//       //
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomeLayout(),
//         ),
//         (route) => false,
//       );
//     }
//     // snackBar
//     ScaffoldMessenger.of(context).showSnackBar(
//       customSnackBar(
//         context,
//         title: S.of(context).loginTile,
//         message: 'تم تسجيل الدخول بنجاح',
//         backgroundColor: AppLightColors.successColor,
//       ),
//     );
//   }
// }
