// import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
// import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// // import '../../../employee/ui/pages/end_visit_page/end_visit_page.dart';

// class MyTimelineTile extends StatelessWidget {
//   MyTimelineTile({
//     Key? key,
//     required this.isLast,
//     required this.status,
//     required this.title,
//     required this.description,
//     required this.isFirst,
//     required this.isPast,
//     this.indicator,
//     this.indicatorColor = AppLightColors.primaryColor,
//     this.iconStyle,
//     this.height = 100,
//   }) : super(key: key);
//   final bool isLast;
//   final bool isFirst;
//   final bool isPast;
//   Widget? indicator;
//   double height;

//   Color indicatorColor;
//   IconStyle? iconStyle;
//   String title;
//   String description;
//   String status;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: status == 'today' || status == 'opened'
//           ? getRes(context, 150)
//           : status == 'finished'
//               ? 65
//               : height,
//       // height: height,
//       child: TimelineTile(
//         isFirst: isFirst,
//         // alignment: TimelineAlign.manual,
//         isLast: isLast,
//         endChild: Padding(
//           padding: EdgeInsets.only(
//             right: getRes(context, 7),
//             // top: 25,
//             top: getRes(
//                 context,
//                 status == 'today' || status == 'opened'
//                     ? 46
//                     : status == 'finished'
//                         ? 0
//                         : 25),
//           ),
//           child: TimelineChild(
//             title: title,
//             s: status,
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => EndVisitPage(),
//               //   ),
//               // );
//             },
//             colorStatus: status == 'today' || status == 'opened'
//                 ? Colors.green.withOpacity(0.2)
//                 : Theme.of(context).colorScheme.primaryContainer,
//             description: description,
//             status: status == 'finished'
//                 ? 'منتهية'
//                 : status == 'today'
//                     ? 'قيد الزيارة'
//                     : status == 'opened'
//                         ? 'مفعلة'
//                         : status == 'incoming'
//                             ? 'غير مفعلة'
//                             : 'بإنتظار التأكيد',
//           ),
//         ),
//         // lineXY: 200,
//         beforeLineStyle: LineStyle(
//           color: Theme.of(context).colorScheme.primaryContainer,
//           thickness: 2.5,
//         ),
//         indicatorStyle: IndicatorStyle(
//           indicator: status == 'today' || status == 'opened'
//               ? glow(context)
//               : status == 'finished'
//                   ? Container(
//                       child: Icon(
//                         Icons.done,
//                         // size: 24,
//                         color: Colors.grey,
//                       ),
//                     )
//                   : status == 'incoming'
//                       ? indicator
//                       : Container(
//                           child: Icon(
//                             Icons.access_time,
//                             color: Colors.grey,
//                             // size: 24,
//                           ),
//                         ),
//           height: getRes(context, 18),
//           width: getRes(context, 18),
//           color: indicatorColor,
//           iconStyle: iconStyle,
//           padding: EdgeInsets.symmetric(
//             vertical: getRes(context, 15),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TimelineChild extends StatelessWidget {
//   TimelineChild({
//     super.key,
//     required this.title,
//     required this.description,
//     this.status = '',
//     this.colorStatus = const Color(0x859292FA),
//     required this.onTap,
//     // required this.openOnTap,
//     required this.s,
//   });
//   final String title;
//   final String description;
//   String status;
//   Color colorStatus;
//   VoidCallback onTap;
//   // VoidCallback openOnTap;
//   String s;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: s == 'today' || s == 'opened' ? onTap : null,
//       borderRadius: BorderRadius.circular(getRes(context, 10)),
//       child: Container(
//         // height: getRes(context, 90),
//         // margin: EdgeInsets.all(20),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(getRes(context, 10)),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: getRes(context, 15),
//               right: getRes(context, 12),
//               left: getRes(context, 6),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SubtitleText(
//                     title,
//                     fontSize: 12,
//                     // style: descriptionStyle(context),
//                   ),
//                   SizedBox(
//                     height: s == 'today' || s == 'opened'
//                         ? getRes(context, 10)
//                         : getRes(context, 15),
//                   ),
//                   DescriptionText(
//                     description,
//                     // fontSize: 11,
//                     // style: bodyStyle(context),
//                   ),
//                   s == 'today' || s == 'opened'
//                       ? SizedBox(
//                           height: getRes(context, 15),
//                         )
//                       : Container(),
//                   s == 'today' || s == 'opened'
//                       ? Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: getRes(context, 10),
//                           ),
//                           child: DefaultButton(
//                             onTap: () {},
//                             alignment: MainAxisAlignment.center,
//                             iconSize: 20,
//                             h: 35,
//                             icon: Icons.email_outlined,
//                             s: 13,
//                             text: s == 'opened'
//                                 ? "تأكيد الزيارة"
//                                 : 'اخبر العميل بوصولي',
//                           ),
//                         )
//                       : Container(),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 3,
//               left: 3,
//               child: Container(
//                 padding: EdgeInsets.only(
//                   left: 12,
//                   right: 11,
//                   top: 5,
//                   bottom: 5,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: colorStatus,
//                 ),
//                 child: DescriptionText(
//                   status,
//                   fontSize: 11,
//                   // style: bodyStyle(context),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget glow(context) {
//   return AvatarGlow(
//     glowColor: Colors.green,
//     glowCount: 2,
//     curve: Curves.easeOutQuad,
//     child: Container(
//       height: getRes(context, 16),
//       width: getRes(context, 16),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.green,
//       ),
//       child: Container(
//         height: getRes(context, 13),
//         width: getRes(context, 13),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.green,
//         ),
//       ),
//     ),
//   );
// }
