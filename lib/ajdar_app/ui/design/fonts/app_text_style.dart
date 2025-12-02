import 'package:flutter/material.dart';

TextStyle? titleLargeStyle(BuildContext context) =>
    Theme.of(context).textTheme.displaySmall;

TextStyle? titleStyle(BuildContext context) =>
    Theme.of(context).textTheme.headlineLarge;
TextStyle? titleMediumStyle(BuildContext context) =>
    Theme.of(context).textTheme.headlineMedium;

TextStyle? titleSmallStyle(BuildContext context) =>
    Theme.of(context).textTheme.headlineSmall;
TextStyle? subtitle1Style(BuildContext context) =>
    Theme.of(context).textTheme.titleLarge;
TextStyle? subtitle2Style(BuildContext context) =>
    Theme.of(context).textTheme.titleMedium;
TextStyle? bodyBoldStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleSmall;
TextStyle? descriptionStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyLarge;
TextStyle? bodyStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyMedium;
TextStyle? subBodyStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodySmall;
