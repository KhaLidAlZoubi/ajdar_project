import 'dart:ffi';

import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';

import '../../domain/app_cubit/app_cubit.dart';

class Dimensions {
  // one side
  EdgeInsets side(context,
          {double? leftSide,
          double? rightSide,
          double? topSide,
          double? bottomSide}) =>
      EdgeInsets.only(
        left: leftSide != null ? getRes(context, leftSide) : 0,
        right: rightSide != null ? getRes(context, rightSide) : 0,
        top: topSide != null ? getRes(context, topSide) : 0,
        bottom: bottomSide != null ? getRes(context, bottomSide) : 0,
      );

  Padding twoSide(context, {required double size, required String side}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: side == 'h' ||
                  side == 'H' ||
                  side == 'horizontal' ||
                  side == 'Horizontal'
              ? getRes(context, size)
              : 0,
          vertical: side == 'v' ||
                  side == 'V' ||
                  side == 'vertical' ||
                  side == 'Vertical'
              ? getRes(context, size)
              : 0,
        ),
      );
}

class AppPadding {
  EdgeInsets headerPadding(context,
          {double bigSide = 20, double smallSide = 5}) =>
      Dimensions().side(
        context,
        leftSide: AppCubit.get(context).lang == 'ar' ? bigSide : smallSide,
        rightSide: AppCubit.get(context).lang == 'en' ? bigSide : smallSide,
      );
  EdgeInsets top20(context) => EdgeInsets.only(
        top: getRes(context, 20),
      );
  EdgeInsets bodyPadding(context, {double top = 30, double bottom = 25}) =>
      Dimensions().side(
        context,
        topSide: top,
        leftSide: 20,
        rightSide: 20,
        bottomSide: bottom,
      );
  EdgeInsets topScreen(context, {double size = 40}) => Dimensions().side(
        context,
        topSide: size,
      );
}
