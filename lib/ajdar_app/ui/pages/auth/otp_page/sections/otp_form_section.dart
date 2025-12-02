import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';

class OTPFormSection extends StatelessWidget {
  OTPFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 6,
        onCompleted: (value) {
          AuthCubit.get(context).code = value;
          AuthCubit.get(context).enableOtp(value);
          print('Completed: ${AuthCubit.get(context).code}');
        },
      ),
    );
  }
}

void anyPrint(var data) {
  // String myData = '$data';
  // print(myData);
}
