import 'package:flutter/material.dart';

class AppDimensions {
  // height screen => 812

  // height figma: 812,
  // height screen => 867.4285714285714
  // width screen => 411.42857142857144
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double width(context) => MediaQuery.of(context).size.width;
  // height
  static double hContainer(context) => height(context) * 0.3333;
  static double h210(context) => height(context) * .242;
  static double h170(context) => height(context) * .195;

  static double h60(context) => height(context) * .069;
  static double h50(context) => height(context) * .0576;
  static double h40(context) => height(context) * .0461;
  static double h30(context) => height(context) * .0345;
  static double h25(context) => height(context) * .0288;
  static double h20(context) => height(context) * .023;
  static double h10(context) => height(context) * .0115;
  static double h15(context) => height(context) * .017;

  static double thirdContainer(context) => height(context) * .3333;
  static double quarterContainer1(context) => height(context) * .19;
  static double twContainer(context) => height(context) * .23;

  static double quarterContainer2(context) => height(context) * .25;

  static double h5(context) => (height(context) + width(context)) * .0061;

  // padding
  static double padding80(context) => height(context) * .0922;
  static double padding20(context) => height(context) * .023;
  static double padding15(context) => height(context) * .017;
  static double padding10(context) => height(context) * .0115;
  // radius
  static double r15(context) => height(context) * .017;
}

double getRes(context, double size) {
  double s = (AppDimensions.height(context) + AppDimensions.width(context)) *
      (size / (812 + 375));
  return s.floorToDouble();
}
