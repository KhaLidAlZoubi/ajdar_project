import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_widgets/description_text.dart';
import '../../../widgets/custom_widgets/subtitle_text.dart';
import '../../profile_page/sections/ads_user_section.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Container(
          child: Padding(
            padding: EdgeInsets.only(top: getRes(context, 20)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundContainer,
                boxShadow: [ShadowTheme().switchThemeShadow],
                borderRadius: BorderRadius.circular(getRes(context, 15)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: getRes(context, 12),
                    ),
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.indigo, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(getRes(context, 15)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline, color: Colors.white),
                        SizedBox(width: getRes(context, 10)),
                        SubtitleText('المعلومات الشخصية', color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: getRes(context, 15)),
                  // image section
                  ImageUserSection(cubit: HomeCubit.get(context)),
                  // field section
                  SizedBox(height: getRes(context, 10)),
                  SubtitleText('معرف المستخدم'),
                  SizedBox(height: getRes(context, 8)),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      horizontal: getRes(context, 20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: getRes(context, 15),
                      vertical: getRes(context, 10),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(getRes(context, 10)),
                    ),
                    child: SubtitleText(
                      '${cubit.meData!.id}',
                      align: TextAlign.center,
                      fontSize: 13,
                    ),
                  ),
                  // field section
                  ...[
                    FiledEditSection(
                      title: 'اسم المستخدم',
                      data: '${cubit.meData!.userName}',
                      onTap: () {
                        showEditField(
                          context,
                          text: cubit.meData!.userName!,
                          title: 'اسم المستخدم',
                        );
                      },
                    ),

                    FiledEditSection(
                      title: 'رقم الهاتف',
                      data: '${cubit.meData!.phoneNumber}',
                      onTap: () {
                        showEditField(
                          context,
                          text: "${cubit.meData!.phoneNumber!}",
                          title: 'رقم الهاتف',
                        );
                      },
                    ),
                    FiledEditSection(
                      title: 'البريد الالكتروني',
                      data: '${cubit.meData!.email}',
                      // onTap: (){},
                    ),
                    // FiledEditSection(),
                    SizedBox(height: getRes(context, 10)),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showEditField(context, {required String text, required String title}) {
    final ctr = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "تعديل $title",
            style: TextStyle(fontSize: getRes(context, 16)),
          ),
          content: TextField(
            controller: ctr,
            keyboardType: title == 'رقم الهاتف'
                ? TextInputType.phone
                : TextInputType.text,
            decoration: InputDecoration(
              labelText: "$title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(getRes(context, 15)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // إغلاق بدون تنفيذ
              },
              child: const Text("تراجع"),
            ),
            ElevatedButton(
              onPressed: () {
                // هنا طبق المنطق للفلترة
                // print("من: $min إلى: $max");

                Navigator.pop(ctx);
                HomeCubit cubit = HomeCubit.get(context);
                if (title == 'رقم الهاتف') {
                  cubit.updatePhone(ctr.text);
                } else {
                  cubit.updateUsername(ctr.text);
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.teal),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              child: const Text("موافق"),
            ),
          ],
        );
      },
    );
  }
}

class FiledEditSection extends StatelessWidget {
  FiledEditSection({
    super.key,
    required this.title,
    required this.data,
    this.onTap,
  });
  final String title;
  final String data;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: getRes(context, 20),
        vertical: getRes(context, 15),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getRes(context, 15),
        // vertical: getRes(context, 5),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: Colors.grey[100]!),
        borderRadius: BorderRadius.circular(getRes(context, 10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubtitleText(title),
              if (onTap != null)
                TextButton.icon(
                  onPressed: onTap ?? () {},
                  icon: Icon(
                    Icons.edit_note_rounded,
                    color: AppLightColors.primaryColor,
                  ),
                  label: Text(
                    'تعديل',
                    style: TextStyle(fontSize: getRes(context, 12)),
                  ),
                ),
            ],
          ),
          SizedBox(height: getRes(context, 5)),
          Divider(color: Colors.grey[200]),
          SizedBox(height: getRes(context, 15)),
          TitleText(data),
          SizedBox(height: getRes(context, 10)),
        ],
      ),
    );
  }
}
