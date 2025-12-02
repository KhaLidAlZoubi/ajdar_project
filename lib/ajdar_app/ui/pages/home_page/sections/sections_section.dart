import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
// import 'package:ajder_project/ajdar_app/domain/home_cubit/section_controller.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/souq/section_details_page/section_details_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/home/section_model.dart';

class SectionsSection extends StatefulWidget {
  SectionsSection({
    super.key,
    // required this.controller,
  });
  // SectionController controller;
  @override
  State<SectionsSection> createState() => _SectionsSectionState();
}

class _SectionsSectionState extends State<SectionsSection> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return cubit.sections.isEmpty && !cubit.sectionLoading
            ? Container(
                child: Column(
                  children: [
                    TitleText('لا توجد بيانات'),
                    SizedBox(
                      height: getRes(context, 10),
                    ),
                    SubtitleText('نتائج البحث 0'),
                    SizedBox(
                      height: getRes(context, 10),
                    ),
                    Image.asset(
                      'assets/images/no_data_search.png',
                      height: getRes(context, 180),
                      width: getRes(context, 180),
                    )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    left: getRes(context, 10),
                    right: getRes(context, 10),
                    top: getRes(context, 10),
                    bottom: getRes(context, 10)),
                child: Column(
                  children: [
                    TitleText(
                      'استكشف الأقسام',
                      fontSize: 18,
                    ),
                    SizedBox(
                      height: getRes(context, 6),
                    ),
                    SubtitleText(
                      'اختر من بين الأقسام المتنوعة وابدأ رحلتك في التجارة الإلكترونية',
                      fontSize: 12,
                    ),
                    SizedBox(
                      height: getRes(context, 15),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: TitleText('الاقسام')),
                    SizedBox(
                      height: getRes(context, 8),
                    ),
                    cubit.sectionLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            // padding: EdgeI,
                            itemCount: cubit.sections.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    mainAxisExtent: 160),
                            // gridDelegate: gridDelegate,
                            itemBuilder: (context, index) {
                              return sectionItem(context,
                                  model: cubit.sections[index], index: index);
                            }),
                  ],
                ),
              );
      },
    );
  }
}

Widget sectionItem(context, {required SectionModel model, required int index}) {
  return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
    HomeCubit cubit = HomeCubit.get(context);
    return InkWell(
      onTap: () {
        cubit.selectSection(index);
        cubit.adsSection();
        print('Pressed');
        Navigator.push(
            context,
            CustomPageTransition.createRoute(
                page: SectionDetailsPage(
                  model: model,
                ),
                isHeroStyle: true));
      },
      child: Container(
        padding: EdgeInsets.only(
            top: getRes(context, 10), bottom: getRes(context, 10)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(getRes(context, 8)),
            boxShadow: [
              ShadowTheme().switchThemeShadow,
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: getRes(context, 90),
              width: getRes(context, 90),
              decoration: BoxDecoration(
                // color: Colors.grey[400],
                // shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(model.image!),
                  fit: BoxFit.fill,
                ),
              ),
              // child: Image.asset('assets/images/home/bundle.jpg'),
            ),
            Spacer(
                // height: getRes(context, 5),
                ),
            SubtitleText(
              model.title!,
              align: TextAlign.center,
            )
          ],
        ),
      ),
    );
  });
}
