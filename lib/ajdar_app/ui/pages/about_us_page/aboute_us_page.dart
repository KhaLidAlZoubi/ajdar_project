import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/gradient_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حول التطبيق'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: getRes(context, 15),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: getRes(context, 20), vertical: getRes(context, 40)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getRes(context, 15)),
          gradient: LinearGradient(colors: [
            Colors.teal[50]!,
            Colors.blue[50]!,
          ], begin: Alignment.centerRight, end: Alignment.centerLeft),
          boxShadow: [
            ShadowTheme().switchThemeShadow,
          ],
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRes(context, 20),
              ),
              child: GradientText(
                'بيع ما لا تحتاج',
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo,
                    Colors.teal,
                  ],
                ),
                style: TextStyle(
                  fontSize: getRes(context, 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: getRes(context, 10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getRes(context, 20),
              ),
              child: GradientText(
                'واكسب المال',
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo,
                    Colors.teal,
                  ],
                ),
                style: TextStyle(
                  fontSize: getRes(context, 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: getRes(context, 15),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getRes(context, 20)),
              child: SubtitleText(
                'انضم الى مجتمعنا المتنامي وابدأ رحلتك في العالم المالي',
                align: TextAlign.center,
                fontSize: 16,
              ),
            ),
            ...[
              SizedBox(
                height: getRes(context, 30),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: getRes(context, 10),
                    horizontal: getRes(context, 10)),
                decoration: BoxDecoration(
                    color: backgroundContainer.withOpacity(.5),
                    borderRadius: BorderRadius.circular(
                      getRes(context, 10),
                    ),
                    boxShadow: [
                      ShadowTheme().switchThemeShadow,
                    ],
                    border: Border.all(color: Colors.grey[200]!)),
                child: Row(
                  children: [
                    Container(
                      height: getRes(context, 50),
                      width: getRes(context, 50),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(
                          getRes(context, 10),
                        ),
                      ),
                      child: Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: getRes(context, 20),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText('الوصول الى الملايين من المشتركين'),
                          SizedBox(
                            height: getRes(context, 5),
                          ),
                          SubtitleText('جمهور كبير ومتنوع يبحث عن منتجاتك ')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: getRes(context, 20),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: getRes(context, 10),
                    horizontal: getRes(context, 10)),
                decoration: BoxDecoration(
                    color: backgroundContainer.withOpacity(.5),
                    borderRadius: BorderRadius.circular(
                      getRes(context, 10),
                    ),
                    boxShadow: [
                      ShadowTheme().switchThemeShadow,
                    ],
                    border: Border.all(color: Colors.grey[200]!)),
                child: Row(
                  children: [
                    Container(
                      height: getRes(context, 50),
                      width: getRes(context, 50),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                          getRes(context, 10),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: getRes(context, 20),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText('أصف اعلانك وبيع اي شيئ'),
                          SizedBox(
                            height: getRes(context, 5),
                          ),
                          SubtitleText('سهولة في إضافة وادارة اعلاناتك')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: getRes(context, 20),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: getRes(context, 10),
                    horizontal: getRes(context, 10)),
                decoration: BoxDecoration(
                    color: backgroundContainer.withOpacity(.5),
                    borderRadius: BorderRadius.circular(
                      getRes(context, 10),
                    ),
                    boxShadow: [
                      ShadowTheme().switchThemeShadow,
                    ],
                    border: Border.all(color: Colors.grey[200]!)),
                child: Row(
                  children: [
                    Container(
                      height: getRes(context, 50),
                      width: getRes(context, 50),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(
                          getRes(context, 10),
                        ),
                      ),
                      child: Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: getRes(context, 20),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText('بيع كل ما تريده بافضل الاسعار'),
                          SizedBox(
                            height: getRes(context, 5),
                          ),
                          SubtitleText('تحكم كامل في اسعارك وربح اكثر')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: getRes(context, 25),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: getRes(context, 30)),
              //   height: getRes(context, 60),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     // color: Colors.
              //     gradient: LinearGradient(
              //       colors: [
              //         Colors.teal,
              //         const Color.fromARGB(255, 109, 182, 241),
              //         const Color.fromARGB(255, 177, 45, 201)
              //       ],
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //     ),
              //     borderRadius: BorderRadius.circular(getRes(context, 15)),
              //     boxShadow: [
              //       ShadowTheme().switchThemeShadow,
              //     ],
              //   ),
              //   child: Row(
              //     spacing: getRes(context, 10),
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       TitleText(
              //         'إضافة اعلان جديد',
              //         color: Colors.white,
              //         fontSize: 15,
              //       ),
              //       Icon(
              //         Icons.arrow_forward,
              //         color: Colors.white,
              //       )
              //     ],
              //   ),
              // ),

              SizedBox(
                height: getRes(context, 30),
              ),
              Divider(
                color: Colors.green[200],
              ),
              SizedBox(
                height: getRes(context, 25),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TitleText(
                        '+10K',
                        fontSize: 18,
                        color: Colors.teal,
                      ),
                      SizedBox(
                        height: getRes(context, 5),
                      ),
                      SubtitleText(
                        'مستخدم نشط',
                        fontSize: 13,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      TitleText(
                        '+100',
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: getRes(context, 5),
                      ),
                      SubtitleText(
                        'اعلان منشور',
                        fontSize: 13,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      TitleText(
                        '95%',
                        fontSize: 18,
                        color: Colors.purple,
                      ),
                      SizedBox(
                        height: getRes(context, 5),
                      ),
                      SubtitleText(
                        'معدل الرضا',
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getRes(context, 30),
              ),
              Container(
                width: double.infinity,
                height: getRes(context, 260),
                margin: EdgeInsets.symmetric(horizontal: getRes(context, 20)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getRes(context, 15)),
                  gradient: LinearGradient(colors: [
                    Colors.teal[50]!,
                    Colors.grey[50]!,
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  boxShadow: [
                    ShadowTheme().switchThemeShadow,
                  ],
                ),
                child: Image.asset('assets/icons/app/tow_app.png'),
              )
            ],
          ],
        ),
      ),
    );
  }
}
