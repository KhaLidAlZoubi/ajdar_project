// import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/app_circle_button.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_text_field.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getRes(context, 15),
                  vertical: getRes(context, 20)),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppCircleButton(
                          paddingLR: 5,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      SizedBox(
                        width: getRes(context, 5),
                      ),
                      TitleText(
                        'سياسة الخصوصية وشروط الاستخدام',
                        // weight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.privacy_tip_outlined,
                              size: 24,
                              color: titleTextThemeColor,
                            ),
                            SizedBox(
                              width: getRes(context, 5),
                            ),
                            TitleText(
                              'سياسة الخصوصية',
                              fontSize: 14,
                              color: titleTextThemeColor,
                              // onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getRes(context, 5),
                        ),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        SizedBox(
                          height: getRes(context, 5),
                        ),
                        SubtitleText(
                          '1. جمع المعلومات',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        TitleText(
                          'نقوم بجمع المعلومات التالية من مستخدمينا:',
                          fontSize: 13,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        Html(
                          data:
                              '''<div dir="rtl" style="list-style-type: disc; margin-right: 14px;">
                              
                  <li>المعلومات الشخصية (الاسم، البريد الإلكتروني، رقم الهاتف)</li>
                  <li>معلومات الحساب وكلمة المرور</li>
                  
                    <li>معلومات الإعلانات المنشورة</li>
                    <li>بيانات التصفح والتفاعل مع الموقع</li>
                  </ul>
                </div>
                ''',
                          // weight: FontWeight.w400,
                          // color: Colors.black,
                        ),
                        SizedBox(
                          height: getRes(context, 15),
                        ),
                        SubtitleText(
                          '2. استخدام المعلومات',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        TitleText(
                          'نستخدم المعلومات المجمعة للأغراض التالية:',
                          fontSize: 13,
                        ),
                        Html(
                            data:
                                '''<div dir="rtl" style="list-style-type: disc; margin-right: 14px;">
                  <li>تقديم خدماتنا وتحسين تجربة المستخدم</li>
                  <li>التواصل مع المستخدمين بخصوص حساباتهم</li>
                  <li>إرسال إشعارات وتحديثات مهمة</li>
                  <li>إرسال إشعارات وتحديثات مهمة</li>
                  </ul>
                </div>
              '''),
                        SizedBox(
                          height: getRes(context, 15),
                        ),
                        SubtitleText(
                          '3. حماية المعلومات',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        TitleText(
                          'نتعهد بحماية معلوماتك الشخصية من خلال:',
                          fontSize: 13,
                        ),
                        Html(
                            data:
                                '''<div dir="rtl" style="list-style-type: disc; margin-right: 14px;">
                  <li>استخدام تقنيات التشفير المتقدمة/li>
                  <li>تطبيق إجراءات أمنية صارمة</li>
                  <li>عدم مشاركة معلوماتك مع أطراف ثالثة دون موافقتك</li>
                  <li>الاحتفاظ بالمعلومات فقط للمدة المطلوبة</li>
                  </ul>
                </div>
              '''),
                        SizedBox(
                          height: getRes(context, 15),
                        ),
                        SubtitleText(
                          '4. ملفات تعريف الارتباط (Cookies)',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        SubtitleText(
                            'نستخدم ملفات تعريف الارتباط لتحسين تجربة التصفح وتذكر تفضيلاتك. يمكنك إدارة إعدادات ملفات تعريف الارتباط من خلال متصفحك.',
                            weight: FontWeight.w400,
                            color: Colors.black),
                        SizedBox(
                          height: getRes(context, 20),
                        ),
                        Divider(
                          color: Colors.grey[20],
                        ),
                        SizedBox(
                          height: getRes(context, 5),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 24,
                              color: titleTextThemeColor,
                            ),
                            SizedBox(
                              width: getRes(context, 5),
                            ),
                            TitleText(
                              'الشروط الاحكام',
                              fontSize: 14,
                              color: titleTextThemeColor,
                              // onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getRes(context, 5),
                        ),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        SizedBox(
                          height: getRes(context, 5),
                        ),
                        SubtitleText(
                          '1. شروط الاستخدام',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        TitleText(
                          'باستخدام موقع سوريا سوق، فإنك توافق على:',
                          fontSize: 13,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        Html(
                          data:
                              '''<div dir="rtl" style="list-style-type: disc; margin-right: 14px;">
                              
                  <li>استخدام الموقع للأغراض القانونية فقط</li>
                  <li>عدم نشر محتوى مسيء أو ضار</li>
                  
                    <li>احترام حقوق الملكية الفكرية</li>
                    <li>عدم إساءة استخدام الخدمات المقدمة</li>
                  </ul>
                </div>
                ''',
                          // weight: FontWeight.w400,
                          // color: Colors.black,
                        ),
                        SizedBox(
                          height: getRes(context, 15),
                        ),
                        SubtitleText(
                          '2. مسؤولية المستخدم',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        TitleText(
                          'أنت مسؤول عن:',
                          fontSize: 13,
                        ),
                        Html(
                            data:
                                '''<div dir="rtl" style="list-style-type: disc; margin-right: 14px;">
                  <li>صحة المعلومات المقدمة</li>
                  <li>حماية كلمة مرور حسابك</li>
                  <li>محتوى الإعلانات المنشورة</li>
                  <li>التواصل مع المشترين والبائعين</li>
                  </ul>
                </div>
              '''),
                        SizedBox(
                          height: getRes(context, 15),
                        ),
                        SubtitleText(
                          '3. قواعد النشر',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        TitleText(
                          'يحظر نشر الإعلانات التي تحتوي على:',
                          fontSize: 13,
                        ),
                        Html(
                            data:
                                '''<div dir="rtl" style="list-style-type: disc; margin-right: 14px;">
                  <li>محتوى مخالف للقوانين السورية</li>
                  <li>منتجات مقلدة أو مزيفة</li>
                  <li>محتوى مسيء أو عنيف</li>
                  <li>إعلانات كاذبة أو مضللة</li>
                  </ul>
                </div>
              '''),
                        SizedBox(
                          height: getRes(context, 15),
                        ),
                        SubtitleText(
                          '4. حقوق الملكية',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        SubtitleText(
                            'جميع المحتويات والعلامات التجارية في الموقع مملوكة لسوريا سوق أو شركائها. يحظر نسخ أو إعادة إنتاج أي محتوى دون إذن مسبق.',
                            weight: FontWeight.w400,
                            color: Colors.black),
                        SizedBox(
                          height: getRes(context, 15),
                        ),
                        SubtitleText(
                          '5. تعديل الشروط',
                          weight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        SubtitleText(
                            'نحتفظ بالحق في تعديل هذه الشروط في أي وقت. سيتم إشعار المستخدمين بأي تغييرات جوهرية.',
                            weight: FontWeight.w400,
                            color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
