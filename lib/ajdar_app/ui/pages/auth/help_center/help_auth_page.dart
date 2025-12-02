import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAuthPage extends StatelessWidget {
  HelpAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مركز الدعم الفني')),
      body: ListView(
        children: [
          Html(
            data: loginData,
            style: {
              "body": Style(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: FontSize(getRes(context, 13)),
                lineHeight: LineHeight(1.6),
                color: Colors.black87,
              ),
              "strong": Style(
                fontFamily: GoogleFonts.cairo(
                  fontWeight: FontWeight.w700,
                ).fontFamily,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: FontSize(getRes(context, 13)),
              ),
              "h3": Style(
                margin: Margins.only(bottom: getRes(context, 10)),
                fontFamily: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ).fontFamily,
                fontSize: FontSize(getRes(context, 16)),
                // margin: EdgeInsets.only(bottom: 10),
                color: AppLightColors.primaryColor,
              ),
              "li": Style(margin: Margins.only(bottom: getRes(context, 10))),
            },
          ),
          Html(
            data: registerData,
            style: {
              "body": Style(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: FontSize(getRes(context, 13)),
                lineHeight: LineHeight(1.6),
                color: Colors.black87,
              ),
              "strong": Style(
                fontFamily: GoogleFonts.cairo(
                  fontWeight: FontWeight.w700,
                ).fontFamily,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: FontSize(getRes(context, 13)),
              ),
              "h3": Style(
                margin: Margins.only(bottom: getRes(context, 10)),
                fontFamily: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ).fontFamily,
                fontSize: FontSize(getRes(context, 16)),
                // margin: EdgeInsets.only(bottom: 10),
                color: AppLightColors.primaryColor,
              ),
              "li": Style(margin: Margins.only(bottom: getRes(context, 10))),
            },
          ),
          Html(
            data: verifyData,
            style: {
              "body": Style(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: FontSize(getRes(context, 13)),
                lineHeight: LineHeight(1.6),
                color: Colors.black87,
              ),
              "strong": Style(
                fontFamily: GoogleFonts.cairo(
                  fontWeight: FontWeight.w700,
                ).fontFamily,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: FontSize(getRes(context, 13)),
              ),
              "h3": Style(
                margin: Margins.only(bottom: getRes(context, 10)),
                fontFamily: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ).fontFamily,
                fontSize: FontSize(getRes(context, 16)),
                // margin: EdgeInsets.only(bottom: 10),
                color: AppLightColors.primaryColor,
              ),
              "li": Style(margin: Margins.only(bottom: getRes(context, 10))),
            },
          ),
          Html(
            data: forgePasswordData,
            style: {
              "body": Style(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: FontSize(getRes(context, 13)),
                lineHeight: LineHeight(1.6),
                color: Colors.black87,
              ),
              "strong": Style(
                fontFamily: GoogleFonts.cairo(
                  fontWeight: FontWeight.w700,
                ).fontFamily,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: FontSize(getRes(context, 13)),
              ),
              "h3": Style(
                margin: Margins.only(bottom: getRes(context, 10)),
                fontFamily: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                ).fontFamily,
                fontSize: FontSize(getRes(context, 16)),
                // margin: EdgeInsets.only(bottom: 10),
                color: AppLightColors.primaryColor,
              ),
              "li": Style(margin: Margins.only(bottom: getRes(context, 10))),
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getRes(context, 15)),
            child: Divider(color: Colors.grey[400]),
          ),
          SizedBox(height: getRes(context, 15)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getRes(context, 30)),
            child: DefaultButton(
              onTap: () {},
              color: Colors.teal,
              text: 'تواصل معنا عبر وتساب',
            ),
          ),
          SizedBox(height: getRes(context, 25)),
        ],
      ),
    );
  }

  String loginData = """
<h3>مساعدة في تسجيل الدخول:</h3>
<ul>
  <li>ادخل <strong>البريد الإلكتروني</strong> الذي استخدمته عند إنشاء الحساب.</li>
  <li>ادخل <strong>كلمة المرور الصحيحة</strong> التي أدخلتها أثناء التسجيل.</li>
  <li>تأكد أن الحساب <strong>مؤكد عبر البريد الإلكتروني</strong>، وإلا سيتم توجيهك لتأكيده ثم إعادة المحاولة.</li>
  <li>في حال نسيت كلمة المرور، يمكنك الضغط على <strong>"نسيت كلمة المرور"</strong> لإعادة تعيينها.</li>
</ul>
""";

  String verifyData = """
<h3>مساعدة في تأكيد الحساب:</h3>
<ul>
  <li>بعد إنشاء الحساب، يتم إرسال <strong>رمز تأكيد</strong> إلى بريدك الإلكتروني.</li>
  <li>افتح البريد الإلكتروني وابحث عن الرسالة التي تحتوي على الرمز.</li>
  <li>أدخل الرمز في الخانة المخصصة داخل التطبيق لتفعيل الحساب.</li>
  <li>في حال لم تصلك الرسالة، يمكنك الضغط على <strong>"إعادة إرسال الرمز"</strong>.</li>
  <li>تأكد من كتابة البريد الإلكتروني بشكل صحيح قبل طلب إعادة الإرسال.</li>
</ul>
""";

  String registerData = """
<h3>مساعدة في إنشاء حساب جديد:</h3>
<ul>
  <li>ادخل <strong>اسمك الكامل</strong> كما ترغب أن يظهر في الحساب.</li>
  <li>اختر <strong>اسم مستخدم فريد</strong> باللغة الإنجليزية فقط (بدون مسافات أو رموز خاصة).</li>
  <li>ادخل <strong>بريدًا إلكترونيًا صحيحًا</strong> لتلقي رمز التأكيد.</li>
  <li>ادخل <strong>رقم هاتف سوري</strong> يبدأ بالرقم <strong>9</strong> (مثال: 9XXXXXXXX) بدون الصفر في البداية.</li>
  <li>قم برفع <strong>صورة شخصية واضحة</strong> — هذا الحقل مطلوب لإتمام التسجيل.</li>
  <li>أنشئ <strong>كلمة مرور قوية</strong> تحتوي على أحرف وأرقام ورموز.</li>
  <li>اقرأ ووافق على <strong>الشروط والأحكام</strong> قبل المتابعة.</li>
  <li>اضغط على <strong>"إنشاء حساب"</strong> لإتمام التسجيل.</li>
</ul>
""";

  String forgePasswordData = """
<h3>مساعدة في استعادة كلمة المرور:</h3>
<ul>
  <li>ادخل <strong>البريد الإلكتروني</strong> المرتبط بحسابك.</li>
  <li>سيتم إرسال <strong>رابط</strong> أو <strong>رمز تأكيد</strong> لإعادة تعيين كلمة المرور إلى بريدك.</li>
  <li>افتح البريد الإلكتروني واضغط على <strong>الرابط المرسل</strong> أو أدخل الرمز في التطبيق.</li>
  <li>قم بإدخال <strong>كلمة مرور جديدة</strong> واحفظها في مكان آمن.</li>
  <li>تأكد من أن كلمة المرور الجديدة مختلفة عن السابقة.</li>
</ul>
""";
}
