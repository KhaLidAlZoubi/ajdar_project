// import 'package:ajder_project/ajdar_app/confirm/dimensions/dimension.dart';
// import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
// import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
// import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
// import 'package:ajder_project/ajdar_app/ui/pages/auth/sign_up_page/sections/body_sign_up_section.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_text_field.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../conest.dart';
// // import '../../../Customer_service/domain/customer_cubit/customer_cubit.dart';
// // import '../../../Customer_service/domain/customer_cubit/customer_state.dart';
// import '../../design/colors/app_colors.dart';
// import '../../widgets/custom_widgets/custom_snack_bar.dart';
// import '../auth/login_page/login_page.dart';

// class EditPassword extends StatelessWidget {
//   const EditPassword({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is EditPasswordSuccess) {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => LoginPage()),
//             (route) => false,
//           );
//           ScaffoldMessenger.of(context).showSnackBar(
//             customSnackBar(
//               context,
//               title: 'كلمة المرور',
//               message: 'تم تحديث كلمة المرور بنجاح',
//               backgroundColor: AppLightColors.titleTextColor,
//             ),
//           );
//           box.remove('token');
//           box.remove('role');
//           box.remove('completeAuth');
//           print(box.getKeys());
//         }
//         if (state is EditPasswordError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             customSnackBar(
//               context,
//               title: 'كلمة المرور',
//               message: 'حدث خطأ, حاول مرة اخرى',
//               backgroundColor: AppLightColors.titleTextColor,
//             ),
//           );
//         }
//         if (state is EditPasswordErrorConnect) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             customSnackBar(
//               context,
//               title: 'تسجيل الخروج',
//               message: 'حدث خطأ, حاول مرة اخرى',
//               backgroundColor: AppLightColors.titleTextColor,
//             ),
//           );
//         }
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         return BlocBuilder<CustomerCubit, CustomerState>(
//           builder: (context, state) {
//             CustomerCubit cubit = CustomerCubit.get(context);
//             return Scaffold(
//               body: Padding(
//                 padding: AppPadding().topScreen(context),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: AppPadding().headerPadding(context),
//                       child: Row(
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(Icons.arrow_back_ios_new_outlined)),
//                           SubtitleText(
//                             'تعديل معلوماتي االشخصية',
//                             weight: FontWeight.w400,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                         height: getRes(context, 200),
//                         child: Image.asset(
//                           'assets/images/edit password.png',
//                           height: getRes(context, 200),
//                         )),
//                     Expanded(
//                       child: ListView(
//                         physics: BouncingScrollPhysics(),
//                         padding: AppPadding().bodyPadding(context),
//                         children: [
//                           MyTextField(
//                             label: "كلمة المرور الحالية ",
//                             hint: "ادخل كلمة المرور القديمة",
//                             controller: cubit.oldPassword,
//                             onChanged: (value) {
//                               cubit.oldPasswordValid(value);
//                             },
//                             border: cubit.showOldPasswordError
//                                 ? Border.all(color: Colors.red)
//                                 : null,
//                             error: cubit.showOldPasswordError
//                                 ? 'كلمة المرور قصيرة للغاية'
//                                 : null,
//                           ),
//                           MyTextField(
//                             label: "كلمة المرور الجديدة ",
//                             hint: "ادخل كلمة المرور الجديدة",
//                             controller: cubit.newPassword,
//                             onChanged: (value) {
//                               cubit.newPasswordValid(value);
//                             },
//                             border: cubit.showNewPasswordError
//                                 ? Border.all(color: Colors.red)
//                                 : null,
//                             error: cubit.showNewPasswordError
//                                 ? 'كلمة المرور قصيرة للغاية'
//                                 : null,
//                           ),
//                           MyTextField(
//                             label: "اعادة كتابة كلمة المرور الجديدة  ",
//                             hint: "قم بتأكيد كلمة المرور",
//                             controller: cubit.confirmPassword,
//                             onChanged: (value) {
//                               cubit.confirmPasswordValid(value);
//                             },
//                             border: cubit.showConfirmPasswordError
//                                 ? Border.all(color: Colors.red)
//                                 : null,
//                             error: cubit.showConfirmPasswordError
//                                 ? 'كلمة المرور قصيرة للغاية'
//                                 : null,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: getRes(context, 30),
//                               right: getRes(context, 30),
//                               top: getRes(context, 30),
//                             ),
//                             child: cubit.isOldPasswordEnable == false ||
//                                     cubit.isNewPasswordEnable == false ||
//                                     cubit.isConfirmPasswordEnable == false
//                                 ? DisableContainer(text: 'تحديث')
//                                 : state is EditPasswordLoading
//                                     ? Center(
//                                         child: CircularProgressIndicator(),
//                                       )
//                                     : DefaultButton(
//                                         onTap: () {
//                                           cubit.editPassword();
//                                         },
//                                         text: "تحديث",
//                                       ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
