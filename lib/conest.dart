import 'package:ajder_project/ajdar_app/data/api_call/http_helper.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

GetStorage box = GetStorage();
String formatTimeDifference(DateTime inputDateTime, {bool isHour = true}) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(inputDateTime);

  // إذا كان الفرق أقل من ساعة
  if (difference.inMinutes < 60) {
    return 'منذ ${difference.inMinutes} دقيقة';
  }
  // إذا كان الفرق ساعة أو أكثر وأقل من يوم
  else if (difference.inHours < 24) {
    return 'منذ ${difference.inHours} ساعة';
  }
  // إذا كان التاريخ هو بالأمس
  else if (now.day - inputDateTime.day == 1 &&
      now.month == inputDateTime.month &&
      now.year == inputDateTime.year) {
    return 'أمس الساعة ${DateFormat('h:mm a', 'ar').format(inputDateTime)}';
  }
  // إذا كان الفرق أكثر من يوم
  else {
    if (isHour) {
      return DateFormat('EEEE، d MMMM، y, الساعة h:mm a', 'ar')
          .format(inputDateTime);
    } else {
      return DateFormat('EEEE، d MMMM، y', 'ar').format(inputDateTime);
    }
  }
}

class MY extends StatelessWidget {
  const MY({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              'تسجيل الدخول',
              style: titleSmallStyle(context),
            ),
            Image.asset(
              'assets/images/sign_up.png',
              height: AppDimensions.h210(context),
            ),
            v(context)
          ],
        ),
      ),
    );
  }

  Widget v(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Phone',
          style: subtitle2Style(context),
        ),
        SizedBox(
          height: AppDimensions.h5(context),
        ),
        Container(
          height: AppDimensions.h60(context),
          child: TextFormField(
            // controller: TextEditingController(),
            textAlignVertical: TextAlignVertical.center,
            style: descriptionStyle(context),
            decoration: InputDecoration(
              hintText: '0996359944',
              hintStyle: descriptionStyle(context),

              // border: InputBorder.none,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.r15(context)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String? imageHandle({
  dynamic network, // يمكن أن يكون String أو List
  String? assets,
  required bool isNetwork,
}) {
  if (isNetwork) {
    if (network == null) return null;

    String? url;

    // إذا كانت network عبارة عن قائمة
    if (network is List && network.isNotEmpty) {
      final firstImage = network[0];
      // if (firstImage is Map && firstImage.containsKey('path')) {
      url = firstImage;
    }
    // أو إذا كانت String مباشرة
    else if (network is String && network.isNotEmpty) {
      url = network;
    }

    if (url == null || url.isEmpty) return null;

    // معالجة localhost
    if (url.contains("http://192.168.229.167:8000")) {
      url = url.replaceFirst("http://192.168.229.167:8000", "$urlIMG");
    }

    return url;
  } else {
    if (assets == null || assets.isEmpty) return null;
    return assets;
  }
}

String pluralArabic(String unit, int value, {bool isFuture = false}) {
  final prefix = isFuture ? 'بعد' : 'منذ';

  if (value == 1) return '$prefix $unit';
  if (value == 2) return '$prefix ${unit}ين';
  if (value >= 3 && value <= 10) return '$prefix $value $unit';
  return '$prefix $value ${unit}ً';
}

String dateTimeHandle(String rawDate) {
  final DateTime date = DateTime.parse(rawDate);
  final DateTime now = DateTime.now();
  final Duration diff = now.difference(date);
  final bool isFuture = diff.isNegative;
  final Duration duration = isFuture ? date.difference(now) : diff;
  final String fullDate =
      '${DateFormat.yMMMMd('ar').format(date)} الساعة ${DateFormat.Hm().format(date)}';

  // أقل من دقيقة
  if (duration.inSeconds < 60) return 'الآن';

  // دقائق
  if (duration.inMinutes < 60) {
    return pluralArabic(
        duration.inMinutes != 2 ? "دقيقة" : "دقيقت", duration.inMinutes,
        isFuture: isFuture);
  }

  // ساعات
  if (duration.inHours < 24 && date.day == now.day) {
    return pluralArabic(
        duration.inHours != 2 ? "ساعة" : "ساعت", duration.inHours,
        isFuture: isFuture);
  }

  // غدًا / أمس
  if (duration.inHours < 48) {
    if (isFuture && date.day == now.add(Duration(days: 1)).day) {
      return 'غدًا الساعة ${DateFormat.Hm().format(date)}';
    } else if (!isFuture && date.day == now.subtract(Duration(days: 1)).day) {
      return 'أمس الساعة ${DateFormat.Hm().format(date)}';
    }
  }

  // أيام
  if (duration.inDays < 7) {
    return '${pluralArabic("يوم", duration.inDays, isFuture: isFuture)}: $fullDate';
  }

  // أسابيع
  if (duration.inDays < 30) {
    int weeks = (duration.inDays / 7).round();
    return '${pluralArabic("أسبوع", weeks, isFuture: isFuture)}: $fullDate';
  }

  // أشهر
  if (duration.inDays < 365) {
    int months = (duration.inDays / 30).round();
    return '${pluralArabic("شهر", months, isFuture: isFuture)}: $fullDate';
  }

  // سنوات
  int years = (duration.inDays / 365).round();
  if (years >= 1 && years < 100) {
    return '${pluralArabic(years != 2 ? "سنة" : "سنت", years, isFuture: isFuture)}: $fullDate';
  }

  // التاريخ الكامل (افتراضي)
  return fullDate;
}
