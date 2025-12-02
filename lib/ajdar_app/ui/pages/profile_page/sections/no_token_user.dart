import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/login_page.dart';
import 'package:flutter/material.dart';

class NoTokenUser extends StatelessWidget {
  const NoTokenUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginPage(),
    );
  }
}
