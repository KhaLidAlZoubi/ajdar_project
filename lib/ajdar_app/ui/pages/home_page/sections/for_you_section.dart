import 'dart:async';
import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/image_background_container.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/componets/image_background_container.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../domain/home_cubit/home_state.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> sliderData = [
    'assets/images/images/ads1.jpeg',
    'assets/images/images/ads2.jpg',
    'assets/images/images/ads3.jpg',
    'assets/images/images/ads4.jpg',
    'assets/images/images/ads4.jpeg',
  ];

  @override
  void initState() {
    super.initState();

    // Timer لتقليب الصفحات
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentIndex < sliderData.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return cubit.sliderData.isEmpty
            ? Container()
            : Column(
                children: [
                  // SmallText(
                  //   'اعلان مدفوع',
                  //   fontSize: 9,
                  // ),
                  SizedBox(height: getRes(context, 10)),
                  Container(
                    height: getRes(context, 170),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned.fill(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: cubit.sliderData.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: index == sliderData.length - 1
                                      ? 0
                                      : getRes(context, 10),
                                  right: getRes(context, 10),
                                ),
                                child: sliderItem(
                                  context,
                                  model: cubit.sliderData[index],
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: getRes(context, 5),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: cubit.sliderData.length,
                            effect: WormEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: Colors.teal,
                              dotColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 10),
                ],
              );
      },
    );
  }

  Widget sliderItem(context, {required Map<String, dynamic> model}) {
    final dynamic imageUrl = model['imageUrl'];
    return Container(
      height: getRes(context, 200),
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.teal[100],
        boxShadow: [ShadowTheme().switchThemeShadow],
        borderRadius: BorderRadius.circular(getRes(context, 10)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageBackgroundContainer(
              isNetwork: imageUrl.isNotEmpty,
              network: imageUrl,
              backgroundColor: Colors.transparent,
              height: getRes(context, 120),
              width: getRes(context, 120),
              icon: Icons.photo,
              radius: BorderRadius.circular(getRes(context, 10)),
            ),
          ),
          Positioned.fill(
            child: Container(
              // color: Colors.black,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getRes(context, 10)),
                color: Colors.black.withOpacity(.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
