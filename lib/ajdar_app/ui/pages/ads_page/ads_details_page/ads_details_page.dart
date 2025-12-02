import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/ads_page/ads_details_page/sections/photo_section.dart';
import 'package:ajder_project/ajdar_app/ui/pages/ads_page/ads_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/expandable_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsDetailsPage extends StatefulWidget {
  AdsDetailsPage({super.key, required this.id});
  int id;

  @override
  State<AdsDetailsPage> createState() => _AdsDetailsPageState();
}

class _AdsDetailsPageState extends State<AdsDetailsPage> {
  @override
  void initState() {
    HomeCubit cubit = HomeCubit.get(context);
    cubit.adsDetailsConnect(widget.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit cubit = HomeCubit.get(context);
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 238, 245, 250),
                Colors.grey[50]!
              ],
            ),
          ),
          child: cubit.adsDetailsLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leadingWidth: 0,
                      leading: Container(),
                      toolbarHeight: getRes(context, 50),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // alignment: Alignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            heroTag: '1',
                            backgroundColor:
                                const Color.fromARGB(255, 221, 226, 240),
                            // backgroundColor:
                            //     AppLightColors.secondaryColor.withOpacity(.3),
                            shape: const CircleBorder(),
                            mini: true,
                            foregroundColor: Color.fromARGB(255, 226, 226, 226),
                            child: Icon(
                              Icons.arrow_back,
                              size: getRes(context, 16),
                              color: Color(0xFF756d54),
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            heroTag: '2',
                            backgroundColor:
                                const Color.fromARGB(255, 221, 226, 240),
                            shape: const CircleBorder(),
                            mini: true,
                            foregroundColor: Color.fromARGB(255, 226, 226, 226),
                            child: Icon(
                              Icons.notifications,
                              size: getRes(context, 16),
                              color: Color(0xFF756d54),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: AppLightColors.primaryColor,
                      expandedHeight: getRes(context, 500),
                      pinned: true,
                      flexibleSpace: PhotoSection(),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getRes(context, 20),
                              right: getRes(context, 20),
                              top: getRes(context, 30),
                              bottom: getRes(context, 10),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.amber,
                                  size: getRes(context, 20),
                                ),
                                SubtitleText(
                                  '  ' + cubit.adsDetails.categoryTitle!,
                                  // fontSize: 13,
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    // showRatingDialog(
                                    //   context,
                                    //   controller.productDetails['name'],
                                    //   id: controller.productDetails['id'],
                                    // );
                                  },
                                  child: Row(
                                    children: [
                                      Wrap(
                                        children: List.generate(
                                          5,
                                          (index) => Icon(
                                            Icons.star,
                                            size: getRes(context, 14),
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getRes(context, 8),
                                      ),
                                      DescriptionText(
                                        '5',
                                        // '${controller.productDetails['rate']} ${S.of(context).rate}',
                                        // '${cubit.productData['data'][index]['rate']}',
                                        fontSize: getRes(context, 13),
                                        // color: AppLightColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TitleText(cubit.adsDetails.title!),
                          ),
                          // deliveryItem()
                          Container(
                            padding: EdgeInsets.only(
                                left: getRes(context, 20),
                                right: getRes(context, 20),
                                top: getRes(context, 10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            EneftyIcons.location_outline,
                                            color: Colors.red,
                                            size: getRes(context, 20),
                                          ),
                                          SizedBox(
                                            width: getRes(context, 6),
                                          ),
                                          SubtitleText(
                                            cubit.adsDetails.location!,
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.date_range,
                                            color: Colors.blue,
                                            size: getRes(context, 20),
                                          ),
                                          SizedBox(
                                            width: getRes(context, 6),
                                          ),
                                          SubtitleText(
                                            'تم النشر: ${DateFormat.yMMMd('en').format(
                                              DateTime.parse(
                                                  cubit.adsDetails.createdAt!),
                                            )}',
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getRes(context, 20),
                                ),
                                // ExpandableText(
                                //   text: cubit.adsDetails.description!,
                                //   height: 2,
                                //   // text:
                                //   // 'kkkkkk hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello',
                                // ),
                                // SizedBox(
                                //   height: getRes(context, 10),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getRes(context, 20),
                            vertical: getRes(context, 10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                              'صاحب الاعلان',
                              fontSize: 14,
                            ),
                            SizedBox(
                              height: getRes(context, 6),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: getRes(context, 12),
                                  horizontal: getRes(context, 12)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  getRes(context, 10),
                                ),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 23,
                                    backgroundColor: Colors.grey[200],
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getRes(context, 10),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TitleText(cubit.adsDetails.userName!),
                                        SizedBox(
                                          height: getRes(context, 10),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: getRes(context, 18),
                                              color: bodyTextThemeColor,
                                            ),
                                            SizedBox(
                                              width: getRes(context, 6),
                                            ),
                                            SubtitleText(
                                              '${cubit.adsDetails.phonNumber}',
                                              color: bodyTextThemeColor,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.more_vert))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (cubit.adsDetails.adFieldDtos != null &&
                        cubit.adsDetails.adFieldDtos!.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getRes(context, 15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getRes(context, 10),
                              ),
                              TitleText(
                                'تفاصيل اكثر عن الاعلان',
                                fontSize: 14,
                              ),
                              SizedBox(
                                height: getRes(context, 10),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: getRes(context, 18),
                                    horizontal: getRes(context, 12)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    ShadowTheme().switchThemeShadow,
                                  ],
                                  borderRadius: BorderRadius.circular(
                                    getRes(context, 10),
                                  ),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleText(
                                      'معلومات الاعلان',
                                      // fontSize: 14,
                                    ),
                                    Divider(),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: getRes(context, 10),
                                                left: getRes(context, 10),
                                                right: getRes(context, 10),
                                                top: getRes(context, 10)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SubtitleText(
                                                  cubit
                                                      .adsDetails
                                                      .adFieldDtos![index]
                                                      .title!,
                                                  fontSize: 13,
                                                ),
                                                TitleText(
                                                  cubit
                                                      .adsDetails
                                                      .adFieldDtos![index]
                                                      .value!,
                                                  fontSize: 14,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              color: Colors.grey[200],
                                            ),
                                        itemCount: cubit
                                            .adsDetails.adFieldDtos!.length),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: getRes(context, 15),
                            left: getRes(context, 15),
                            right: getRes(context, 15)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getRes(context, 18),
                              horizontal: getRes(context, 12)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              ShadowTheme().switchThemeShadow,
                            ],
                            borderRadius: BorderRadius.circular(
                              getRes(context, 10),
                            ),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText('وصف الاعلان'),
                              Divider(
                                color: Colors.grey[300],
                              ),
                              DescriptionText(
                                cubit.adsDetails.description!,
                                fontSize: 13,
                                height: 2,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(getRes(context, 15)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getRes(context, 18),
                              horizontal: getRes(context, 12)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              ShadowTheme().switchThemeShadow,
                            ],
                            borderRadius: BorderRadius.circular(
                              getRes(context, 10),
                            ),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText('رقم الاعلان'),
                              Divider(
                                color: Colors.grey[300],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleText(
                                    "#${cubit.adsDetails.id!}",
                                    fontSize: 13,
                                  ),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                    label: Text('ابلغ عن اساءة'),
                                    style: ButtonStyle(
                                      foregroundColor:
                                          WidgetStatePropertyAll(Colors.red),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        bottomNavigationBar: cubit.adsDetailsLoading
            ? SizedBox.shrink()
            : Container(
                height: getRes(context, 130),
                padding: EdgeInsets.symmetric(
                    horizontal: getRes(context, 20),
                    vertical: getRes(context, 15)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      getRes(context, 30),
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.1),
                        offset: Offset(-5, -5),
                        blurRadius: 10)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: getRes(context, 10),
                        ),
                        Icon(
                          Icons.monetization_on,
                          color: Colors.blue[900],
                        ),
                        SizedBox(
                          width: getRes(context, 10),
                        ),
                        TitleText(
                          'سعر هذا الاعلان',
                          fontSize: 14,
                        ),
                        SizedBox(
                          width: getRes(context, 15),
                        ),
                        TitleText(
                          priceValue(cubit.adsDetails.price!),
                          color: Colors.green[900],
                        )
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            onTap: () async {
                              final Uri telUri = Uri.parse(
                                  'tel:${cubit.adsDetails.phonNumber}');
                              if (await canLaunchUrl(telUri)) {
                                await launchUrl(telUri);
                              }
                            },
                            // w: 90,
                            text: 'اتصال',
                            icon: Icons.phone,
                            iconSize: 20,
                            alignment: MainAxisAlignment.center,
                          ),
                        ),
                        SizedBox(
                          width: getRes(context, 10),
                        ),
                        Expanded(
                          child: DefaultButton(
                            onTap: () async {
                              final Uri whatsappUri = Uri.parse(
                                  'https://wa.me/${cubit.adsDetails.phonNumber}');
                              if (await canLaunchUrl(whatsappUri)) {
                                await launchUrl(whatsappUri);
                              }
                            },
                            // w: 90,
                            borderColor: Colors.green[700],
                            color: Colors.white,
                            textColor: Colors.green[700]!,
                            // text: 'وتساب',
                            icon: Icons.chat,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/whatsapp.png',
                                  height: getRes(context, 25),
                                  width: getRes(context, 25),
                                ),
                                SizedBox(
                                  width: getRes(context, 7),
                                ),
                                SubtitleText(
                                  'وتساب',
                                  fontSize: 14,
                                  color: Colors.green,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                            // iconSize: 20,
                            // alignment: MainAxisAlignment.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
