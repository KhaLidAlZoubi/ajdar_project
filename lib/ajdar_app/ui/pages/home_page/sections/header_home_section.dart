import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_widgets/route_animation.dart';
import '../../souq/section_details_page/section_details_page.dart';

class RealBounceBallClean extends StatefulWidget {
  @override
  _RealBounceBallCleanState createState() => _RealBounceBallCleanState();
}

class _RealBounceBallCleanState extends State<RealBounceBallClean>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 35)
            .chain(CurveTween(curve: Curves.easeIn)), // نزول سريع
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 35, end: 0)
            .chain(CurveTween(curve: Curves.easeOut)), // صعود ناعم
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getRes(context, 250),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2ecc71), Color(0xff27ae60)],
        ),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                right: 25,
                top: 40 + _animation.value,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.15), // شفافة وبسيطة
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleText(
                                    'سوق سوريا',
                                    fontSize: 25,
                                    color: Colors.white,
                                    weight: FontWeight.w800,
                                    letter: 1.7,
                                  ),
                                  TitleText(
                                    'المفتوح',
                                    fontSize: 25,
                                    letter: 1.7,
                                    color: Colors.orange,
                                    weight: FontWeight.w800,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Container(
                                    height: getRes(context, 40),
                                    width: getRes(context, 40),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(.3)),
                                    child: Icon(
                                      Icons.favorite,
                                      size: getRes(context, 20),
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getRes(context, 10),
                                  ),
                                  Container(
                                    height: getRes(context, 40),
                                    width: getRes(context, 40),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(.3)),
                                    child: Icon(
                                      Icons.light_mode,
                                      size: getRes(context, 20),
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getRes(context, 15),
                          ),
                          AnimatedTextKit(
                            isRepeatingAnimation: false,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                'منصة رقمية متطورة للبيع والشراء في سوريا - اربح من منزلك بسهولة وأمان',
                                textStyle: TextStyle(
                                  fontSize: getRes(context, 14),
                                  fontFamily: 'Cairo',
                                  color: Colors.grey[200],
                                ),
                                speed: const Duration(milliseconds: 30),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 20,
                  child: Row(
                    children: [
                      DefaultButton(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     CustomPageTransition.createRoute(
                          //         page: SectionDetailsPage(),
                          //         isHeroStyle: true));
                        },
                        color: Colors.orange,
                        text: 'ابدأ الان مجانا',
                        w: getRes(context, 105),
                        textColor: Colors.black,
                        r: 25,
                        isShadow: true,
                      ),
                      SizedBox(
                        width: getRes(context, 15),
                      ),
                      DefaultButton(
                        onTap: () {},
                        color: Colors.transparent,
                        borderColor: Colors.white,
                        isShadow: true,
                        text: 'تعرف علينا',
                        w: getRes(context, 105),
                        textColor: Colors.white,
                        r: 25,
                      ),
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}
