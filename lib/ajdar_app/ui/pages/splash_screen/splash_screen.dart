import 'dart:async';
import 'package:ajder_project/ajdar_app/ui/layout/home/home_layout.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../design/colors/app_colors.dart';
import '../../design/dimensions/app_dimensions.dart';
import 'dart:math' as math;
import 'package:characters/characters.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController logoController;
  late AnimationController partController;

  late Animation<Offset> logoSlide;
  late Animation<double> logoFade;

  late Animation<Offset> part1Slide;
  late Animation<Offset> part2Slide;

  late Animation<double> part1Fade;
  late Animation<double> part2Fade;

  bool showText = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.play(AssetSource('sound/splash.mp3'));
    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    partController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    logoSlide = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
      // end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: logoController,
      curve: Curves.easeOut,
    ));

    logoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: logoController,
      curve: Curves.easeIn,
    ));

    part1Slide = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: partController,
      curve: Curves.easeOut,
    ));

    part2Slide = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: partController,
      curve: Curves.easeOut,
    ));

    part1Fade = Tween<double>(begin: 0, end: 1).animate(partController);
    part2Fade = Tween<double>(begin: 0, end: 1).animate(partController);

    logoController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          showText = true;
        });
        partController.forward();

        // الانتقال بعد 5 ثوانٍ
        Future.delayed(const Duration(milliseconds: 2300), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeUserLayout(),
            ),
          );
        });
      });
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    partController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                // Color(0xFFf8f9fa),
                // Color(0xFFdfe6e9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // شعار التطبيق
                Image.asset(
                  'assets/icons/app/GIF.gif',
                  width: getRes(context, 170),
                  height: getRes(context, 170),
                ),
                SizedBox(height: getRes(context, 20)),

                // اسم التطبيق
                // if (showText)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       FadeTransition(
                //         opacity: part1Fade,
                //         child: SlideTransition(
                //           position: part1Slide,
                //           child: Text(
                //             "سوق",
                //             style: TextStyle(
                //               fontFamily: 'Cairo-Bold',
                //               fontSize: getRes(context, 24),
                //               fontWeight: FontWeight.bold,
                //               color: AppLightColors.primaryColor,
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(width: getRes(context, 8)),
                //       FadeTransition(
                //         opacity: part2Fade,
                //         child: SlideTransition(
                //           position: part2Slide,
                //           child: Text(
                //             "سوريا المفتوح",
                //             style: TextStyle(
                //               fontFamily: 'Cairo-Bold',
                //               fontSize: getRes(context, 24),
                //               fontWeight: FontWeight.bold,
                //               color: Colors.blue,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),

                // SizedBox(height: getRes(context, 15)),

                // عبارة التطبيق
                if (showText)
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    totalRepeatCount: 1,
                    animatedTexts: [
                      MultiColoredTyperAnimatedText(
                        'سوق سوريا المفتوح',
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo-Reg',
                          fontWeight: FontWeight.w800,
                          color:
                              Colors.black, // لون افتراضي للكلمات غير المحددة
                        ),
                        coloredWords: {
                          'سوق': TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo-Reg',
                            fontWeight: FontWeight.w800,
                            color: Colors.blue,
                          ),
                          'سوريا': TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo-Reg',
                            fontWeight: FontWeight.w800,
                            color: Colors.green,
                          ),
                          'المفتوح': TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo-Reg',
                            fontWeight: FontWeight.w800,
                            color: Colors.blue,
                          ),
                        },
                        speed: const Duration(milliseconds: 40),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultiColoredTyperAnimatedText extends AnimatedText {
  final Duration speed;
  final Map<String, TextStyle> coloredWords;
  final Curve curve;

  late final Animation<double> _typingAnimation;

  MultiColoredTyperAnimatedText(
    String text, {
    required TextStyle textStyle,
    required this.coloredWords,
    this.speed = const Duration(milliseconds: 40),
    this.curve = Curves.linear,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: Duration(
              milliseconds: speed.inMilliseconds * text.characters.length),
        );

  @override
  void initAnimation(AnimationController controller) {
    _typingAnimation = Tween<double>(
      begin: 0,
      end: textCharacters.length.toDouble(),
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final int count = _typingAnimation.value.floor();
    final String visible = textCharacters.take(count).toString();

    return RichText(
      textAlign: textAlign,
      text: _buildTextSpan(visible),
    );
  }

  TextSpan _buildTextSpan(String visible) {
    final List<TextSpan> spans = [];

    // تقسيم النص المرئي إلى كلمات
    final words = visible.split(' ');
    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      final style = coloredWords[word] ?? textStyle;
      spans.add(TextSpan(text: "$word ", style: style));
    }

    return TextSpan(children: spans);
  }

  @override
  Widget completeText(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: _buildTextSpan(text),
    );
  }
}
