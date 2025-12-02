import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/data/model/home/section_model.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/pages/notification_page/notification_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/ads_item_widget.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/app_circle_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/image_background_container.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/search_advanced.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:ajder_project/conest.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/model/home/ads_home_model.dart';
import '../../../design/dimensions/app_dimensions.dart';
import '../../area_s_page/area_s_page.dart';

class SectionDetailsPage extends StatefulWidget {
  SectionDetailsPage({super.key, required this.model});
  SectionModel model;

  @override
  State<SectionDetailsPage> createState() => _SectionDetailsPageState();
}

class _SectionDetailsPageState extends State<SectionDetailsPage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    final cubit = HomeCubit.get(context);
    cubit.subSectionConnect(widget.model.id);
    cubit.getAds(sectionName: widget.model.id!, isRefresh: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !cubit.adsLoading &&
          cubit.adsHasMore) {
        cubit.getAds(
          sectionName: widget.model.id!,
        );
      }
    });
  }

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
            toolbarHeight: getRes(context, 80),
            title: Container(
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
                          cubit.getAds(
                            isRefresh: true,
                            subSection: cubit.subSectionIndex == null
                                ? null
                                : cubit.subSections[cubit.subSectionIndex!].id,
                            sectionName: cubit.sections[cubit.sectionIndex!].id,
                            // search: ,
                          );
                        } else {
                          cubit.getAds(
                            isRefresh: true,
                            subSection: cubit.subSectionIndex == null
                                ? null
                                : cubit.subSections[cubit.subSectionIndex!].id,
                            sectionName: cubit.sections[cubit.sectionIndex!].id,
                            max: maxPriceController.text,
                            min: minPriceController.text,
                            search: value,
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
                          cubit.getAds(
                            isRefresh: true,
                            subSection: cubit.subSectionIndex == null
                                ? null
                                : cubit.subSections[cubit.subSectionIndex!].id,
                            sectionName: cubit.sections[cubit.sectionIndex!].id,
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
          body: cubit.subSectionLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => cubit.getAds(
                      sectionName: widget.model.id!, isRefresh: true),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getRes(context, 15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: getRes(context, 20)),
                              Row(
                                children: [
                                  TitleText(widget.model.title!, fontSize: 20),
                                  SizedBox(width: getRes(context, 5)),
                                  DescriptionText('( ${cubit.ads.length} )',
                                      fontSize: 14),
                                ],
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
                                      foregroundColor: WidgetStatePropertyAll(
                                          Color(0xFF333333)),
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
                                            showAdvancedSearchDialog(
                                                context: context);
                                          },
                                          child: Icon(Icons
                                              .format_list_bulleted_rounded)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: getRes(context, 10)),
                              Wrap(
                                spacing: getRes(context, 10),
                                runSpacing: getRes(context, 10),
                                children: List.generate(
                                    cubit.subSections.length, (index) {
                                  return subSectionItem(
                                      cubit.subSections[index].title!,
                                      index: index);
                                }),
                              ),
                              SizedBox(height: getRes(context, 20)),
                            ],
                          ),
                        ),
                      ),

                      /// SliverList للإعلانات
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index < cubit.ads.length) {
                              return adsItem(context,
                                  model: cubit.ads[index], index: index);
                            } else {
                              // مؤشر تحميل عند جلب صفحة جديدة
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                          },
                          childCount: cubit.ads.length +
                              ((cubit.adsLoading && cubit.adsHasMore) ? 1 : 0),
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
          cubit.getAds(
            isRefresh: true,
            subSection: cubit.subSectionIndex == null
                ? null
                : cubit.subSections[cubit.subSectionIndex!].id,
            sectionName: cubit.sections[cubit.sectionIndex!].id,
            max: maxPriceController.text,
            min: minPriceController.text,
            search: searchCtrl.text,
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
                          cubit.getAds(
                            isRefresh: true,
                            subSection: null,
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
                cubit.getAds(
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
