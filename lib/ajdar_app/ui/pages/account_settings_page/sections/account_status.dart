import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_widgets/description_text.dart';
import '../../../widgets/custom_widgets/subtitle_text.dart';
import '../../profile_page/sections/ads_user_section.dart';

class AccountStatus extends StatelessWidget {
  const AccountStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getRes(context, 20)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundContainer,
          boxShadow: [
            ShadowTheme().switchThemeShadow,
          ],
          borderRadius: BorderRadius.circular(
            getRes(context, 15),
          ),
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
                  colors: [
                    Colors.teal,
                    Colors.green,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    getRes(context, 15),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: getRes(context, 10),
                  ),
                  SubtitleText(
                    'حالة الحساب',
                    color: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(
              height: getRes(context, 15),
            ),
            // image section

            // field section
            ...[
              StatusItem(
                colors: [
                  const Color.fromARGB(255, 245, 254, 245),
                  Colors.green[50]!,
                  Colors.green[100]!,
                  Colors.green[600]!
                ],
                icon: Icons.email_outlined,
                text: 'تأكيد البريد الإلكتروني',
                isActive: true,
              ),
              StatusItem(
                colors: [
                  const Color.fromARGB(255, 231, 241, 248),
                  Colors.blue[50]!,
                  Colors.blue[100]!,
                  Colors.blue[600]!
                ],
                icon: Icons.phone_outlined,
                text: 'تأكيد رقم الهاتف',
                isActive: false,
              ),
              StatusItem(
                colors: [
                  const Color.fromARGB(255, 247, 242, 248),
                  Colors.purple[50]!,
                  Colors.purple[100]!,
                  Colors.purple[600]!
                ],
                icon: Icons.lock_outline,
                text: 'المصادقة الثنائية',
                isActive: false,
              ),
              StatusItem(
                colors: [
                  const Color.fromARGB(255, 255, 250, 250),
                  // const Color.fromARGB(255, 245, 254, 245),
                  Colors.red[50]!,
                  Colors.red[100]!,
                  Colors.red[600]!
                ],
                icon: Icons.beach_access_outlined,
                // icon: Icons.beach_access_outlined,
                text: 'حالة الحساب',
                isActive: true,
              ),
              StatusItem(
                colors: [
                  const Color.fromARGB(255, 255, 253, 246),
                  // const Color.fromARGB(255, 245, 254, 245),
                  Colors.amber[50]!,
                  Colors.amber[100]!,
                  Colors.amber[600]!
                ],
                icon: Icons.assignment_late_sharp,
                text: 'تفعيل القفل',
                isActive: true,
              ),
              StatusItem(
                colors: [
                  const Color.fromARGB(255, 252, 253, 254)!,
                  // const Color.fromARGB(255, 255, 253, 246),
                  // const Color.fromARGB(255, 245, 254, 245),
                  Colors.blueGrey[50]!,
                  Colors.blueGrey[100]!,
                  Colors.blueGrey[600]!
                ],
                icon: Icons.error_outline_rounded,
                text: 'محاولات الفشل',
                isActive: true,
              ),
              // FiledEditSection(),
              SizedBox(
                height: getRes(context, 10),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class StatusItem extends StatelessWidget {
  StatusItem(
      {super.key,
      required this.colors,
      required this.icon,
      required this.text,
      this.isActive = false});
  final List<Color> colors;
  final IconData icon;
  final String text;
  bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getRes(context, 30), vertical: getRes(context, 20)),
      padding: EdgeInsets.symmetric(
        horizontal: getRes(context, 20),
        vertical: getRes(context, 20),
      ),
      decoration: BoxDecoration(
        color: colors[0],
        border: Border.all(
          color: colors[1],
        ),
        borderRadius: BorderRadius.circular(
          getRes(context, 15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(
                  getRes(context, 15),
                ),
                decoration: BoxDecoration(
                  color: colors[2],
                  borderRadius: BorderRadius.circular(
                    getRes(context, 10),
                  ),
                ),
                child: Icon(
                  icon,
                  color: colors[3],
                ),
              ),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.indigo,
              ),
            ],
          ),
          SizedBox(
            height: getRes(context, 15),
          ),
          SubtitleText(
            text,
            fontSize: 14,
          ),
          SizedBox(
            height: getRes(context, 10),
          ),
          TitleText(
            isActive ? 'مفعل' : 'غير مفعل',
            color: isActive ? Colors.indigo : Colors.red,
          )
        ],
      ),
    );
  }
}
