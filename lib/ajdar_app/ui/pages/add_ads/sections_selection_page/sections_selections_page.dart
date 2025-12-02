import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/data/model/dynamic_field_model.dart';
import 'package:ajder_project/ajdar_app/data/model/home/section_model.dart';
import 'package:ajder_project/ajdar_app/data/model/home/sub_section_model.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/layout/home/home_layout.dart';
import 'package:ajder_project/ajdar_app/ui/pages/add_ads/sections_selection_page/sections/dynamic_field_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/add_ads/sections_selection_page/sections/idea_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/add_ads/sections_selection_page/sections/photo_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/profile_page/sections/ads_user_section.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/app_circle_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/dotter_border.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/image_background_container.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_dropdown.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_text_field.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:ajder_project/conest.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../widgets/custom_widgets/messages/animated_snack_bar.dart';

class SectionsSelectionsPage extends StatefulWidget {
  const SectionsSelectionsPage({super.key});

  @override
  State<SectionsSelectionsPage> createState() => _SectionsSelectionsPageState();
}

class _SectionsSelectionsPageState extends State<SectionsSelectionsPage> {
  @override
  void initState() {
    HomeCubit cubit = HomeCubit.get(context);
    cubit.pageAds = 0;
    cubit.searchSections('');
    searchCtrl.clear();

    // selectedValues = List.filled(HomeCubit.get(context).dynamicFileds.length, null);

    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is AddAdsSuccess) {
        CustomSnackbar.show(
            context: context,
            message: 'تم اضافة اعلاناك بنجاح اذهب الى قسم اعلاناتي لرؤيتها',
            type: SnackbarType.success,
            topPosition: true);
      }
      if (state is AddAdsError) {
        CustomSnackbar.show(
            context: context,
            message: 'حدث خطأ ما, حاول مجددا',
            type: SnackbarType.error,
            topPosition: true);
      }
      if (state is AddAdsErrorConnect) {
        CustomSnackbar.show(
            context: context,
            message: 'خطأ في الاتصال, حاول مجددا',
            type: SnackbarType.error,
            topPosition: true);
      }
    }, builder: (context, state) {
      return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('اضافة اعلان'),
          ),
          body: Padding(
            padding: EdgeInsets.all(
              getRes(context, 15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cubit.pageAds != 0)
                  DefaultButton(
                    onTap: () {
                      cubit.removePageAds();
                    },
                    w: getRes(context, 55),
                    h: getRes(context, 42),
                    color: backgroundContainer,
                    icon: Icons.arrow_back,
                    textColor: AppLightColors.primaryColor,
                  ),
                if (cubit.pageAds != 0)
                  SizedBox(
                    height: getRes(context, 20),
                  ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRes(context, 10),
                      vertical: getRes(context, 10),
                    ),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleText(cubit.pageAds == 4
                                ? 'مكتمل'
                                : cubit.pageAds == 0
                                    ? 'اختيار قسم'
                                    : cubit.pageAds == 1
                                        ? 'اختيار الفئة'
                                        : "ادخال صور الاعلان"),
                            DescriptionText('${cubit.pageAds} من 4 مكتمل '),
                          ],
                        ),
                        SizedBox(
                          height: getRes(context, 20),
                        ),
                        Container(
                          height: getRes(context, 15),
                          width: double.infinity,
                          // color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.circular(getRes(context, 15)),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: cubit.pageAds == 0
                                    ? 0
                                    : cubit.pageAds == 1
                                        ? (MediaQuery.of(context).size.width *
                                                .25) -
                                            getRes(context, 35)
                                        : cubit.pageAds == 2
                                            ? (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .5) -
                                                getRes(context, 35)
                                            : cubit.pageAds == 3
                                                ? (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .75) -
                                                    getRes(context, 35)
                                                : double.infinity,
                                height: getRes(context, 15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.teal,
                                        Colors.green,
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        getRes(context, 15))),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: getRes(context, 10),
                        ),
                        if (cubit.pageAds == 0) ...[
                          MyTextField(
                              controller: searchCtrl,
                              onChanged: (value) {
                                cubit.searchSections(value);
                              },
                              suffix: cubit.searching
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: getRes(context, 10),
                                          horizontal: getRes(context, 10)),
                                      child: const SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              // label: '',
                              preIcon:
                                  Icon(EneftyIcons.search_normal_2_outline),
                              hint: 'ابحث عن الاقسام',
                              // controller: TextEditingController(),
                              label: ''),
                          Container(
                            height: getRes(context, 15),
                          ),
                          cubit.sections.isEmpty && !cubit.sectionLoading
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
                              : ListView.builder(
                                  itemCount: cubit.sections.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return sectionsSelectionsItem(context,
                                        model: cubit.sections[index],
                                        onTap: () {
                                      cubit.selectSection(index);
                                      cubit.nextPageAds();
                                    });
                                  }),
                        ],
                        if ((cubit.pageAds == 1 && cubit.subSectionLoading) ||
                            (cubit.pageAds == 2 && cubit.dynamicFiledLoading))
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (cubit.pageAds == 1 &&
                            cubit.subSectionLoading == false) ...[
                          MyTextField(
                              hint: 'ابحث عن الأقسام الفرعية',
                              controller: TextEditingController(),
                              label: ''),
                          Container(
                            height: getRes(context, 15),
                          ),
                          ListView.builder(
                              itemCount: cubit.subSections.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return subSectionsSelectionsItem(context,
                                    model: cubit.subSections[index], onTap: () {
                                  cubit.selectSubSection(index);
                                  cubit.nextPageAds();
                                });
                              }),
                        ],
                        if (cubit.pageAds == 2 &&
                            cubit.dynamicFiledLoading == false)
                          DynamicField(),
                        if (cubit.pageAds == 3) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getRes(context, 10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TitleText('رفع صور الاعلان'),
                                SubtitleText(
                                  'ارفع صور جذابة وواضحة لاعلانك ( الحد الاقصى 10 صور )',
                                  align: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              // borderRadius:
                              // BorderRadius.circular(getRes(context, 10)),
                              color: Colors.orange[100],
                            ),
                            child: DottedBorder(
                                // radius: Radius.circular(10),
                                // radius: BorderRadius.circular(getRes(context, 10)),
                                color: Colors.orange[800]!,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: getRes(context, 15),
                                      horizontal: getRes(context, 5)),
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.brown,
                                      ),
                                      Column(
                                        children: [
                                          TitleText(
                                            'مهم: ',
                                            color: Colors.brown,
                                            fontSize: 14,
                                          ),
                                          SubtitleText(
                                            'الصورة الاولى ستكون الصورة الاصلية للاعلان - يجب على الاقل رفع ثلاث صور',
                                            color: Colors.brown,
                                            align: TextAlign.center,
                                            fontSize: 13,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: getRes(context, 25),
                          ),
                          PhotoGridSection(),
                          // IdeaSection()
                        ],
                        if (cubit.pageAds == 4) ...[
                          Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: getRes(context, 25),
                                ),
                                Image.asset(
                                  'assets/images/done.png',
                                  height: getRes(context, 150),
                                  width: getRes(context, 150),
                                ),
                                SizedBox(
                                  height: getRes(context, 25),
                                ),
                                TitleText('تمت اضافة الاعلان بنجاح'),
                                SizedBox(
                                  height: getRes(context, 10),
                                ),
                                SubtitleText(
                                  'يمكنك تصفح اعلاناتك في ملفك الشخصي',
                                  align: TextAlign.center,
                                ),
                                SizedBox(
                                  height: getRes(context, 30),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getRes(context, 25)),
                                  child: DefaultButton(
                                    onTap: () {
                                      cubit.goToMyAds();
                                      cubit.clearAdData();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        CustomPageTransition.createRoute(
                                            page: MyAdsPage(), isModal: true),
                                        (r) => false,
                                      );
                                    },
                                    text: 'تصفح اعلاناتي',
                                  ),
                                ),
                                SizedBox(
                                  height: getRes(context, 20),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getRes(context, 25)),
                                  child: DefaultButton(
                                    onTap: () {
                                      cubit.goToHome();
                                      cubit.clearAdData();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        CustomPageTransition.createRoute(
                                            page: HomeUserLayout(),
                                            isModal: true),
                                        (r) => false,
                                      );
                                    },
                                    textColor: titleTextThemeColor,
                                    borderColor: titleTextThemeColor,
                                    color: Colors.transparent,
                                    text: 'رجوع للرئيسية',
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  sectionsSelectionsItem(context,
      {required SectionModel model, required VoidCallback onTap}) {
    final imageUrl = model.image;
    return Padding(
      padding: EdgeInsets.only(
        bottom: getRes(context, 15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getRes(context, 15), vertical: getRes(context, 20)),
          decoration: BoxDecoration(
            color: backgroundContainer,
            border: Border.all(color: Colors.grey[100]!),
            borderRadius: BorderRadius.circular(getRes(context, 10)),
            boxShadow: [
              ShadowTheme().switchThemeShadow,
            ],
          ),
          child: Row(
            children: [
              ...[
                Container(
                  // height: 150,
                  // width: 150,
                  // color: Colors.amber,
                  child: ImageBackgroundContainer(
                    isNetwork: imageUrl!.isNotEmpty,
                    network: imageUrl,
                    backgroundColor: Colors.transparent,
                    height: getRes(context, 60),
                    width: getRes(context, 60),
                    // radius: BorderRadius.circular(
                    // getRes(context, 10),
                    // ),
                  ),
                ),
                SizedBox(
                  width: getRes(context, 10),
                ),
                SubtitleText(model.title!),
                // ImageBackgroundContainer(isNetwork: )
              ],
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
            ],
          ),
        ),
      ),
    );
  }
  // List<String?> selectedValues = List.filled(HomeCubit.get(context).dynamicFileds.length, null);

  subSectionsSelectionsItem(
    context, {
    required SubSectionModel model,
    required VoidCallback onTap,
  }) {
    // final imageUrl = model.image;
    return Padding(
      padding: EdgeInsets.only(
        bottom: getRes(context, 15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getRes(context, 15), vertical: getRes(context, 15)),
          decoration: BoxDecoration(
            color: backgroundContainer,
            border: Border.all(color: Colors.grey[100]!),
            borderRadius: BorderRadius.circular(getRes(context, 10)),
            boxShadow: [
              ShadowTheme().switchThemeShadow,
            ],
          ),
          child: Row(
            children: [
              ...[
                // Container(
                //   // height: 150,
                //   // width: 150,
                //   // color: Colors.amber,
                //   child: ImageBackgroundContainer(
                //     isNetwork: imageUrl!.isNotEmpty,
                //     network: imageUrl,
                //     backgroundColor: Colors.transparent,
                //     height: getRes(context, 60),
                //     width: getRes(context, 60),
                //     // radius: BorderRadius.circular(
                //     // getRes(context, 10),
                //     // ),
                //   ),
                // ),

                SubtitleText(model.title!),
                // ImageBackgroundContainer(isNetwork: )
              ],
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
            ],
          ),
        ),
      ),
    );
  }
}
