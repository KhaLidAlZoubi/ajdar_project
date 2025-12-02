import 'package:ajder_project/ajdar_app/services/start_page_serveces.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          StartPage().submitOnboarding(context);
        },
        child: Icon(Icons.read_more),
      ),
    );
  }
}
