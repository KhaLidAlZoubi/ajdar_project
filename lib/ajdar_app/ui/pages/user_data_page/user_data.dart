import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/noTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/home_cubit/home_cubit.dart';
import '../../../domain/home_cubit/home_state.dart';

class UserDataPage extends StatelessWidget {
  const UserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Scaffold(
              body: Column(
                  // children: [
                  //   Container(
                  //     height: getRes(context, 240),
                  //     child: Stack(
                  //       children: [
                  //         Container(
                  //           alignment: Alignment.topCenter,
                  //           padding: EdgeInsets.only(
                  //             top: getRes(context, 50),
                  //             left: getRes(context, 20),
                  //             right: getRes(context, 20),
                  //           ),
                  //           width: double.infinity,
                  //           height: getRes(context, 200),
                  //           color: AppLightColors.primaryColor,
                  //           child: Row(
                  //             children: [
                  //               InkWell(
                  //                 onTap: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //                 child: Icon(
                  //                   Icons.arrow_back_ios,
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 width: getRes(context, 7),
                  //               ),
                  //               SubtitleText(
                  //                 'تعديل معلوماتي االشخصية',
                  //                 weight: FontWeight.w700,
                  //                 color: Colors.white,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Positioned(
                  //           bottom: 0,
                  //           left: getRes(context, 0),
                  //           right: getRes(context, 0),
                  //           child: Stack(
                  //             alignment: Alignment.center,
                  //             children: [
                  //               Container(
                  //                 height: getRes(context, 80),
                  //                 width: getRes(context, 80),
                  //                 decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color: Colors.blue,
                  //                 ),
                  //               ),
                  //               Container(
                  //                 height: getRes(context, 75),
                  //                 width: getRes(context, 75),
                  //                 decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color: backgroundContainer,
                  //                 ),
                  //               ),
                  //               Container(
                  //                 height: getRes(context, 70),
                  //                 width: getRes(context, 70),
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                     image: NetworkImage(
                  //                         '$urlIMG${HomeCubit.get(context).profileData['data']['customer']['buildingsImages'][0]['path']}'),
                  //                     fit: BoxFit.fill,
                  //                   ),
                  //                   shape: BoxShape.circle,
                  //                   color: const Color.fromARGB(255, 69, 82, 92),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     height: getRes(context, 20),
                  //   ),
                  //   TitleText(
                  //     HomeCubit.get(context).profileData['data']['name'],
                  //   ),
                  //   SizedBox(
                  //     height: getRes(context, 12),
                  //   ),
                  //   Directionality(
                  //     textDirection: TextDirection.ltr,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.phone,
                  //           color: AppLightColors.primaryColor,
                  //           size: getRes(context, 16),
                  //         ),
                  //         SizedBox(
                  //           width: getRes(context, 5),
                  //         ),
                  //         DescriptionText(
                  //           HomeCubit.get(context).profileData['data']['phone'],
                  //           fontSize: 13,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     height: getRes(context, 10),
                  //   ),
                  //   Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: getRes(context, 20),
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         SizedBox(
                  //           height: getRes(context, 26),
                  //         ),
                  //         EditField(
                  //           label: 'رقم الهوية',
                  //           text: HomeCubit.get(context).profileData['data']
                  //               ['customer']['identity_number'],
                  //           icon: Icons.person,
                  //         ),
                  //         SubtitleText("الموقع"),
                  //         SizedBox(
                  //           height: getRes(context, 0),
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.location_on,
                  //                   color: Colors.red[700],
                  //                   size: getRes(context, 17),
                  //                 ),
                  //                 SizedBox(
                  //                   width: getRes(context, 5),
                  //                 ),
                  //                 Expanded(
                  //                   child: DescriptionText(
                  //                     '${HomeCubit.get(context).profileData['data']['customer']['area']}, ${HomeCubit.get(context).profileData['data']['customer']['neighborhood']}, ${HomeCubit.get(context).profileData['data']['customer']['street']}',
                  //                     fontSize: 13,
                  //                     color: titleTextThemeColor,
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             EditAddressPage()));
                  //               },
                  //               child: Container(
                  //                 height: getRes(context, 33),
                  //                 alignment: Alignment.center,
                  //                 width: getRes(context, 100),
                  //                 decoration: BoxDecoration(
                  //                   borderRadius:
                  //                       BorderRadius.circular(getRes(context, 8)),
                  //                   color: AppLightColors.primaryColor,
                  //                 ),
                  //                 child: DescriptionText(
                  //                   'تحديث موقعي',
                  //                   color: Colors.white,
                  //                   fontSize: 11,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: getRes(context, 12),
                  //         ),
                  //         EditField(
                  //           label: 'رقم المنزل',
                  //           text: HomeCubit.get(context).profileData['data']
                  //               ['customer']['house_number'],
                  //           icon: Icons.home,
                  //         ),
                  //         SubtitleText(
                  //           'صورة البناء',
                  //         ),
                  //         SizedBox(height: getRes(context, 10)),
                  //       ],
                  //     ),
                  //   ),
                  // ],

                  ),
            );
          },
        );
      },
    );
  }
}

class EditField extends StatelessWidget {
  EditField({
    super.key,
    required this.label,
    required this.text,
    required this.icon,
  });
  final String label;

  String text;

  IconData icon;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return NoTextField(
          text: text,
          noLeftPadding: true,
          label: label,
          suffix: Icon(
            icon,
            size: getRes(context, 18),
            color: AppLightColors.primaryColor,
          ),
        );
      },
    );
  }
}
