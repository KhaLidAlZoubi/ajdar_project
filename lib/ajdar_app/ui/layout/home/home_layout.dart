import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
// import 'package:ajder_project/ajdar_app/ui/design/fonts/app_text_style.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/ads_item_widget.dart';
import 'package:ajder_project/conest.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';

class HomeUserLayout extends StatefulWidget {
  const HomeUserLayout({super.key});

  @override
  State<HomeUserLayout> createState() => _HomeUserLayoutState();
}

class _HomeUserLayoutState extends State<HomeUserLayout> {
  bool _isScrolledDown = false;
  @override
  void initState() {
    HomeCubit.get(context).isSuccessAut();
    BackButtonInterceptor.add(myInterceptor);
    // HomeCubit.get(context).getProfileConnect();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  // bool isProductLoading = false;
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white, // ✅ لون الخلفية أبيض
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getRes(context, 10),
          ), // ✅ انحناء الحواف بمقدار 10
        ),
        title: Text("تأكيد الخروج", style: TextStyle(fontFamily: 'Cairo-Reg')),
        content: Text(
          "هل أنت متأكد أنك تريد الخروج من التطبيق؟",
          style: TextStyle(fontFamily: 'Cairo-Reg'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("إلغاء", style: TextStyle(fontFamily: 'Cairo-Reg')),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white, // ✅ لون الزر أحمر
              foregroundColor: AppLightColors.titleTextColor, // ✅ لون النص أبيض
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getRes(context, 10),
                ), // ✅ انحناء زر الخروج
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Future.delayed(const Duration(milliseconds: 300), () {
                SystemNavigator.pop(); // إغلاق التطبيق
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red, // ✅ لون الزر أحمر
              foregroundColor: Colors.white, // ✅ لون النص أبيض
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getRes(context, 10),
                ), // ✅ انحناء زر الخروج
              ),
            ),
            child: Text("موافق", style: TextStyle(fontFamily: 'Cairo-Reg')),
          ),
        ],
      ),
    );
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (Navigator.of(context).canPop()) {
      return false; // السماح بالرجوع في الصفحات الداخلية
    }
    _showExitDialog();
    return true; // منع الإغلاق الفوري للتطبيق
  }

  @override
  Widget build(BuildContext context) {
    final HomeCubit cubit = HomeCubit.get(context);
    final double navBarHeight = getRes(context, 80);
    final double fabSize = 56.0;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            clipBehavior: Clip.none,
            children: [cubit.pages[cubit.selectIndex]],
          ),

          /// ✅ شريط التنقل السفلي
          bottomNavigationBar: Stack(
            children: [
              NavigationBar(
                elevation: 0.4,
                selectedIndex: cubit.selectIndex,
                onDestinationSelected: (index) {
                  cubit.selectPage(index);
                  if (index == 1) {
                    cubit.adsHome();
                    cubit.subSections.clear();
                    cubit.sectionIndex = null;
                    cubit.subSectionIndex = null;
                  }
                },
                height: navBarHeight,
                backgroundColor: Theme.of(
                  context,
                ).bottomNavigationBarTheme.backgroundColor,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home, color: AppLightColors.bodyColor),
                    label: S.of(context).home,
                    selectedIcon: Icon(
                      Icons.home,
                      color: colorScheme(context).primary,
                    ),
                  ),
                  NavigationDestination(
                    icon: Icon(
                      EneftyIcons.category_2_outline,
                      color: AppLightColors.bodyColor,
                    ),
                    label: 'الاعلانات',
                    selectedIcon: Icon(
                      EneftyIcons.category_2_outline,
                      color: colorScheme(context).primary,
                    ),
                  ),
                  SizedBox.shrink(),
                  // NavigationDestination(
                  //   icon: SizedBox.shrink(),
                  //   label: '',
                  // ),
                  // ❌ زر الإضافة سيكون في الأعلى بدل هذا
                  NavigationDestination(
                    icon: Icon(
                      Icons.favorite_border,
                      color: AppLightColors.bodyColor,
                    ),
                    label: 'المفضلة',
                    selectedIcon: Icon(
                      Icons.favorite,
                      color: colorScheme(context).primary,
                    ),
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.person_outline,
                      color: AppLightColors.bodyColor,
                    ),
                    label: S.of(context).me,
                    selectedIcon: Icon(
                      Icons.person,
                      color: colorScheme(context).primary,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                left: (MediaQuery.of(context).size.width / 2) - 45,
                right: (MediaQuery.of(context).size.width / 2) - 45,
                child: InkWell(
                  onTap: () {
                    if (box.read('token') != null) {
                      cubit.clearAdData();
                      cubit.selectPage(2);
                    } else {
                      cubit.clearAdData();
                      cubit.selectPage(2);
                      // showLoginDialog(context);
                    }
                    // cubit.selectPage(2);
                  },
                  child: Container(
                    height: getRes(context, 45),
                    width: getRes(context, 45),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green[400]!,
                          Colors.teal[400]!,
                          Colors.blue,
                        ],
                      ),
                      // color: Colors.orange[400],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_enhance, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
