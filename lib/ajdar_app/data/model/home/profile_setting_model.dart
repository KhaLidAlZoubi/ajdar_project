import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';

class ProfileSettingModel {
  IconData icon;
  String text;
  bool? isLogout;
  bool? isTheme;
  ProfileSettingModel({
    required this.icon,
    required this.text,
    this.isLogout,
    this.isTheme,
  });
}

List<ProfileSettingModel> profileModel(context) => [
      ProfileSettingModel(
        icon: Ionicons.settings_outline,
        text: S.of(context).personal,
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.credit_card,
        text: 'شراء نقاط',
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.dark_mode_outlined,
        text: S.of(context).dark,
        isLogout: false,
        isTheme: true,
      ),
      ProfileSettingModel(
        icon: Icons.translate,
        text: S.of(context).language,
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.face,
        text: S.of(context).contact,
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.shield_outlined,
        text: S.of(context).privacy,
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.logout,
        text: S.of(context).logout,
        isLogout: true,
        isTheme: false,
      ),
    ];

List<ProfileSettingModel> customerProfileModel(context) => [
      ProfileSettingModel(
        icon: Icons.people,
        text: 'الموظفين',
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.lock_outline,
        text: S.of(context).change,
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.dark_mode_outlined,
        text: S.of(context).dark,
        isLogout: false,
        isTheme: true,
      ),
      ProfileSettingModel(
        icon: Icons.translate,
        text: S.of(context).language,
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.email_outlined,
        text: 'الرسائل الواردة',
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.shield_outlined,
        text: S.of(context).privacy,
        isLogout: false,
        isTheme: false,
      ),
      ProfileSettingModel(
        icon: Icons.logout,
        text: S.of(context).logout,
        isLogout: true,
        isTheme: false,
      ),
    ];
