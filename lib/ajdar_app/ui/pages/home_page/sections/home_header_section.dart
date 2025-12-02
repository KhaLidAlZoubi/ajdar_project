import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getRes(context, 80),
      decoration: BoxDecoration(
        color: backgroundContainer,
        boxShadow: [
          ShadowTheme().switchThemeShadow,
        ],
      ),
      // child: Row,
    );
  }
}
