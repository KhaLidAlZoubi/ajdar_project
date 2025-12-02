import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/data/model/home/section_model.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/area_s_page/area_s_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/notification_page/notification_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/ads_item_widget.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/app_circle_button.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/image_background_container.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/no_data.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/search_advanced.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AdsPage extends StatefulWidget {
  AdsPage({super.key});
  // SectionModel model;

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    final cubit = HomeCubit.get(context);
    // cubit.subSectionConnect(widget.model.id);
    cubit.getAllAds(isRefresh: true);
    cubit.sectionIndex = null;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !cubit.allAdsLoading &&
          cubit.allAdsHasMore) {
        cubit.getAllAds(
            // sectionName: widget.model.id!,
            );
      }
    });
  }

  bool isMore = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is ActionWishlistSuccess) {
        CustomSnackbar.show(
            context: context,
            message: 'تم اضافة هذا العنصر الى المفضة',
            type: SnackbarType.success);
      }
      if (state is ActionWishlistError) {
        CustomSnackbar.show(
            context: context,
            message: 'حدث خطأ في اضافة هذا العنصر الى المفضلة, حاول مجددا',
            type: SnackbarType.error);
      }
      if (state is ActionWishlistErrorConnect) {
        CustomSnackbar.show(
            context: context,
            message: 'حدث خطأ في الاتصال, حاول مجددا',
            type: SnackbarType.error);
      }
      if (state is RemoveWishlistSuccess) {
        CustomSnackbar.show(
            context: context,
            message: 'تم ازالة هذا العنصر من المفضة',
            type: SnackbarType.success);
      }
      if (state is RemoveWishlistError) {
        CustomSnackbar.show(
            context: context,
            message: 'حدث خطأ في ازالة هذا العنصر من المفضلة, حاول مجددا',
            type: SnackbarType.error);
      }
      if (state is RemoveWishlistErrorConnect) {
        CustomSnackbar.show(
            context: context,
            message: 'حدث خطأ في الاتصال, حاول مجددا',
            type: SnackbarType.error);
      }
    }, builder: (context, state) {
      return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: Image.asset('assets/icons/app/appp.png'),
            toolbarHeight: getRes(context, 80),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getRes(context, 10),
                      vertical: getRes(context, 0)),
                  decoration: BoxDecoration(
                      color: backgroundContainer,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchCtrl,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              cubit.getAllAds(
                                isRefresh: true,
                                subSection: cubit.subSectionIndex == null
                                    ? null
                                    : cubit
                                        .subSections[cubit.subSectionIndex!].id,
                                sectionName: cubit.sectionIndex == null
                                    ? null
                                    : cubit.sections[cubit.sectionIndex!].id,
                                // search: ,
                              );
                            } else {
                              cubit.getAllAds(
                                isRefresh: true,
                                subSection: cubit.subSectionIndex == null
                                    ? null
                                    : cubit
                                        .subSections[cubit.subSectionIndex!].id,
                                sectionName: cubit.sectionIndex == null
                                    ? null
                                    : cubit.sections[cubit.sectionIndex!].id ??
                                        null,
                                search: value,
                                min: minPriceController.text,
                                max: maxPriceController.text,
                              );
                            }
                          },
                          style: TextStyle(
                            fontFamily: 'Cairo-Reg',
                            fontSize: getRes(context, 13),
                          ),
                          decoration: InputDecoration(
                            hintText: 'ابحث هنا ...',
                            hintStyle: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: getRes(context, 14),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (searchCtrl.text.isNotEmpty)
                        SizedBox(
                          width: getRes(context, 6),
                        ),
                      if (searchCtrl.text.isNotEmpty)
                        InkWell(
                            onTap: () {
                              setState(() {
                                searchCtrl.clear();
                              });
                              cubit.getAllAds(
                                isRefresh: true,
                                subSection: cubit.subSectionIndex == null
                                    ? null
                                    : cubit
                                        .subSections[cubit.subSectionIndex!].id,
                                sectionName: cubit.sectionIndex == null
                                    ? null
                                    : cubit.sections[cubit.sectionIndex!].id,
                                max: maxPriceController.text,
                                min: minPriceController.text,
                                // search: value,
                              );
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ))
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              // InkWell(onTap: () {}, child: Icon(Icons.share)),
              // SizedBox(width: getRes(context, 10)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CustomPageTransition.createRoute(
                        page: NotificationPage(),
                        isHeroStyle: true,
                      ),
                    );
                  },
                  child: Icon(Icons.notifications)),
              SizedBox(width: getRes(context, 10)),
            ],
            foregroundColor: Colors.white,
            backgroundColor: AppLightColors.primaryColor,
          ),
          body: RefreshIndicator(
            onRefresh: () => cubit.getAllAds(isRefresh: true),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getRes(context, 15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: getRes(context, 20)),
                        Wrap(
                          spacing: 5,
                          runSpacing: 8,
                          children: List.generate(
                              cubit.sections.length >= 5 && !isMore
                                  ? 6
                                  : cubit.sections.length, (index) {
                            return sectionItem(
                              context,
                              index: index,
                              isMoree: false,
                              model: cubit.sections[index],
                            );
                          }),
                        ),
                        if (isMore)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getRes(context, 8)),
                            child: sectionItem(
                              context,
                              index: 100,
                              isMoree: true,
                              model: cubit.sections[0],
                            ),
                          ),
                        // Row(
                        //   children: [
                        //     TitleText(widget.model.title!, fontSize: 20),
                        //     SizedBox(width: getRes(context, 5)),
                        //     DescriptionText('( 22,254 )', fontSize: 14),
                        //   ],
                        // ),
                        SizedBox(height: getRes(context, 10)),
                        if (cubit.isAdvanced)
                          Wrap(
                            spacing: getRes(context, 8),
                            runSpacing: getRes(context, 8),
                            children: List.generate(cubit.subSections.length,
                                (index) {
                              return subSectionItem(
                                  cubit.subSections[index].title!,
                                  index: index);
                            }),
                          ),
                        SizedBox(height: getRes(context, 10)),
                        Row(
                          children: [
                            Icon(EneftyIcons.location_outline,
                                size: getRes(context, 22)),
                            SizedBox(width: getRes(context, 5)),
                            TextButton.icon(
                              style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: getRes(context, 10)),
                                ),
                                foregroundColor:
                                    WidgetStatePropertyAll(Color(0xFF333333)),
                              ),
                              iconAlignment: IconAlignment.end,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CustomPageTransition.createRoute(
                                        page: GovernoratesSearchPage(),
                                        isBack: true));
                              },
                              label: Text(
                                  cubit.area == '' && cubit.areaName == ''
                                      ? 'كل المدن'
                                      : '${cubit.areaName}${cubit.area}'),
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Color(0xFF333333),
                                  size: getRes(context, 26)),
                            ),
                            // AppCircleButton(
                            //     paddingLR: 0,
                            //     child: Icon(
                            //       Icons.close,
                            //       color: Colors.red,
                            //       size: getRes(context, 20),
                            //     )),
                            // SmallText(
                            //   'حذف',
                            // ),
                            Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // AppCircleButton(
                                //     paddingLR: 5,
                                //     onTap: () {
                                //       showMinMaxPriceDialog();
                                //     },
                                //     child: Icon(Icons.swap_vert)),
                                AppCircleButton(
                                    paddingLR: 5,
                                    onTap: () {
                                      // cubit.trueAdvanced();
                                      showAdvancedSearchDialog(
                                          context: context);
                                    },
                                    child: Icon(
                                        Icons.format_list_bulleted_rounded)),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: getRes(context, 20)),
                      ],
                    ),
                  ),
                ),
                if (cubit.allAds.isEmpty && cubit.allAdsLoading == false)
                  SliverToBoxAdapter(
                    child: NoData(),
                  ),

                /// SliverList للإعلانات
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < cubit.allAds.length) {
                        return adsItem(context,
                            model: cubit.allAds[index], index: index);
                      } else {
                        // مؤشر تحميل عند جلب صفحة جديدة
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                    childCount: cubit.allAds.length +
                        ((cubit.allAdsLoading && cubit.allAdsHasMore) ? 1 : 0),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  Widget subSectionItem(String text, {required int index}) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit cubit = HomeCubit.get(context);
      return InkWell(
        onTap: () {
          cubit.selectSubSection(index);

          cubit.getAllAds(
            search: searchCtrl.text,
            min: minPriceController.text,
            max: maxPriceController.text,
            isRefresh: true,
            subSection: cubit.subSections[index].id,
            sectionName: cubit.sections[cubit.sectionIndex!].id,
          );
        },
        child: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.all(getRes(context, 8)),
          decoration: BoxDecoration(
            color: cubit.subSectionIndex == index
                ? backgroundContainer
                : Colors.blue[50],
            border: Border.all(
              color: Colors.grey[200]!,
            ),
            boxShadow: cubit.subSectionIndex == index
                ? [
                    ShadowTheme().switchThemeShadow,
                  ]
                : null,
            borderRadius: BorderRadius.circular(
              getRes(context, 15),
            ),
          ),
          child: cubit.subSectionIndex == index
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SubtitleText(text),
                    AppCircleButton(
                        onTap: () {
                          cubit.clearSelectSubSection();
                          cubit.getAllAds(
                            isRefresh: true,
                            subSection: null,
                            search: searchCtrl.text,
                            min: minPriceController.text,
                            max: maxPriceController.text,
                            sectionName: cubit.sections[cubit.sectionIndex!].id,
                          );
                        },
                        paddingTB: 0,
                        paddingLR: 5,
                        child: Icon(Icons.close))
                  ],
                )
              : SubtitleText(text),
        ),
      );
    });
  }

  Widget sectionItem(context,
      {required int index,
      required SectionModel model,
      required bool isMoree}) {
    dynamic imageUrl = model.image;
    HomeCubit cubit = HomeCubit.get(context);
    return InkWell(
      onTap: () {
        if (index == 5 && !isMore) {
          setState(() {
            isMoree = !isMoree;
            isMore = !isMore;
          });
        } else if (isMoree) {
          setState(() {
            isMoree = !isMoree;
            isMore = !isMore;
          });
        } else {
          cubit.selectSection(index);
          cubit.subSectionConnect(cubit.sections[cubit.sectionIndex!].id);

          cubit.getAllAds(
              isRefresh: true,
              search: searchCtrl.text,
              min: minPriceController.text,
              max: maxPriceController.text,

              // subSection: cubit.subSections[index].id,
              sectionName: cubit.sections[cubit.sectionIndex!].id);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getRes(context, 8), vertical: getRes(context, 10)),
        decoration: BoxDecoration(
          // color: backgroundContainer,
          gradient: LinearGradient(
              colors: cubit.sectionIndex == index || isMoree
                  ? [
                      Colors.teal,
                      Colors.blue,
                    ]
                  : [
                      backgroundContainer,
                      backgroundContainer,
                    ]),
          borderRadius: BorderRadius.circular(getRes(context, 10)),
          boxShadow: [
            ShadowTheme().switchThemeShadow,
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (index == 5 && !isMore) || (isMoree)
                ? Icon(
                    isMoree
                        ? Icons.arrow_upward
                        : Icons.arrow_downward_outlined,
                    color: cubit.sectionIndex == index
                        ? Colors.white
                        : Colors.grey,
                  )
                : CircleAvatar(
                    radius: 15,
                    child: ImageBackgroundContainer(
                      network: imageUrl,
                      isNetwork: imageUrl != null,
                      height: getRes(context, 25),
                      width: getRes(context, 25),
                      backgroundColor: Colors.transparent,
                      // isCircle: true,
                    ),
                  ),
            SizedBox(
              width: getRes(context, 5),
            ),
            TitleText(
              (index == 5 && !isMore)
                  ? 'عرض المزيد'
                  : isMoree
                      ? 'عرض اقل'
                      : model.title!,
              fontSize: 13,
              color: cubit.sectionIndex == index
                  ? Colors.white
                  : AppLightColors.titleTextColor,
            )
          ],
        ),
      ),
    );
  }

  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  showMinMaxPriceDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text("فلترة حسب السعر"),
          content: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: minPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "من",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(getRes(context, 15))),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: maxPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "إلى",
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(getRes(context, 15))),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // إغلاق بدون تنفيذ
              },
              child: const Text("تراجع"),
            ),
            ElevatedButton(
              onPressed: () {
                final min = minPriceController.text;
                final max = maxPriceController.text;
                // هنا طبق المنطق للفلترة
                print("من: $min إلى: $max");

                Navigator.pop(ctx);
                HomeCubit cubit = HomeCubit.get(context);
                cubit.getAllAds(
                    min: min,
                    max: max,
                    isRefresh: true,
                    sectionName: cubit.sectionIndex == null
                        ? null
                        : cubit.sections[cubit.sectionIndex!].id,
                    subSection: cubit.subSectionIndex == null
                        ? null
                        : cubit.subSections[cubit.subSectionIndex!].id,
                    search: searchCtrl.text);
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.teal),
                  foregroundColor: WidgetStatePropertyAll(Colors.white)),
              child: const Text("موافق"),
            ),
          ],
        );
      },
    );
  }
}
// import 'package:intl/intl.dart';

String priceValue(var value) {
  return NumberFormat('#,###.##').format(value);
}
