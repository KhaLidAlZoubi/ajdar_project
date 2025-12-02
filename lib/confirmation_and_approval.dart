import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ConfirmationAndApproval extends StatelessWidget {
  const ConfirmationAndApproval({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      "باكمال العملية فأنت توافق على ",
                      style: descriptionStyle(context),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          "شروط الأستخدام  ",
                          style: descriptionStyle(context)!.apply(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.lightBlue,
                              color: Colors.blue),
                        )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: AppDimensions.height(context) * .46,
                ),
                DefaultButton(
                  onTap: () {},
                  text: "الموافقة والمتابعة",
                  w: double.infinity,
                  color: Colors.blue,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "خروج",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
