import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/data/model/home/wishlist_model.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/ads_page/ads_details_page/ads_details_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/ads_page/ads_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/login_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/ads_item_widget.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/app_circle_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/image_background_container.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/no_data.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/no_wishlist_data.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:ajder_project/conest.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    HomeCubit cubit = HomeCubit.get(context);
    cubit.getWishList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
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
      if (state is DeleteWishlistSuccess) {
        CustomSnackbar.show(
            context: context,
            message: 'تم ازالة جميع العناصر من المفضلة بنجاح',
            type: SnackbarType.success);
      }
      if (state is DeleteWishlistError) {
        CustomSnackbar.show(
            context: context,
            message: 'حدث خطأ في ازالة العناصر من المفضلة, حاول مجددا',
            type: SnackbarType.error);
      }
      if (state is DeleteWishlistErrorConnect) {
        CustomSnackbar.show(
            context: context,
            message: 'حدث خطأ في الاتصال, حاول مجددا',
            type: SnackbarType.error);
      }
    }, builder: (context, state) {
      return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        if (box.read('token') != null)
          return Scaffold(
            appBar: AppBar(
              leadingWidth: getRes(context, 40),
              // toolbarHeight: getRes(context, 100),
              backgroundColor: backgroundContainer,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    'المفضلة',
                    fontSize: 16,
                    color: Colors.teal,
                  ),
                ],
              ),
              leading: Image.asset('assets/icons/app/appp.png'),
              actions: [
                if (cubit.wishlistData.isNotEmpty)
                  AppCircleButton(
                    onTap: () {
                      _showDeleteAllDialog();
                    },
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    paddingLR: 5,
                  ),
                AppCircleButton(
                  onTap: () {},
                  child: Icon(Icons.notifications),
                  paddingLR: 5,
                ),
                SizedBox(
                  width: getRes(context, 11),
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.teal[50]!, Colors.grey[50]!],
              )),
              child: cubit.wishlistLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: cubit.getWishList,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: getRes(context, 15),
                          vertical: getRes(context, 20),
                        ),
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleText(
                                    'مفضلتي',
                                    fontSize: 20,
                                  ),
                                  SizedBox(
                                    height: getRes(context, 5),
                                  ),
                                  SubtitleText('ادارة العانصر المحفوظة'),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 22,
                                    color: Colors.teal[900],
                                  ),
                                  SizedBox(
                                    width: getRes(context, 5),
                                  ),
                                  SubtitleText(
                                    '${cubit.wishlistData.length} من العناصر',
                                    color: Colors.teal[900],
                                    fontSize: 13,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: getRes(context, 25),
                          ),
                          if (cubit.wishlistData.isNotEmpty)
                            ListView.builder(
                              itemCount: cubit.wishlistData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return wishlistItem(
                                  context,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CustomPageTransition.createRoute(
                                            page: AdsDetailsPage(
                                                id: cubit.wishlistData[index]
                                                    .adId!)));
                                  },
                                  model: cubit.wishlistData[index],
                                  index: index,
                                );
                              },
                            )
                          else
                            NoWishlistData(),
                          if (cubit.wishlistData.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getRes(context, 25)),
                              child: TextButton(
                                style: ButtonStyle(
                                  // padding: WidgetStatePropertyAll(
                                  // EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                  // ),
                                  // shape: WidgetStatePropertyAll(OutlinedBorder()),
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.teal[400]),
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                ),
                                onPressed: () {
                                  cubit.goToAds();
                                },
                                child: Text(
                                  'تصفح الاعلانات',
                                  style:
                                      TextStyle(fontSize: getRes(context, 10)),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
          );
        else
          return LoginPage();
      });
    });
  }

  Widget wishlistItem(context,
      {required WishlistModel model,
      required VoidCallback onTap,
      required int index}) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit cubit = HomeCubit.get(context);
      return Padding(
        padding: EdgeInsets.only(
          bottom: getRes(context, 15),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundContainer,
              borderRadius: BorderRadius.circular(
                getRes(context, 12),
              ),
              boxShadow: [
                ShadowTheme().switchThemeShadow,
              ],
              border: Border.all(
                  color: backgroundContainer, width: getRes(context, 5)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageBackgroundContainer(
                      isNetwork:
                          model.imageUrl != null || model.imageUrl!.isNotEmpty,
                      network: model.imageUrl![0],
                      height: getRes(context, 200),
                      width: double.infinity,
                      radius: BorderRadius.circular(getRes(context, 12)),
                    ),
                    // SizedBox(
                    //   height: getRes(context, 15),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getRes(context, 15),
                          vertical: getRes(context, 18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(
                            model.title!,
                            fontSize: 20,
                          ),
                          SizedBox(
                            height: getRes(context, 10),
                          ),
                          DescriptionText(
                            model.description!,
                            fontSize: 13,
                            line: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: getRes(context, 16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.grey[100],
                                    child: Icon(
                                      Icons.monetization_on,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getRes(context, 5),
                                  ),
                                  TitleText(
                                    priceValue(model.price!),
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.grey[100],
                                    child: Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(
                                    width: getRes(context, 5),
                                  ),
                                  TitleText(
                                    DateFormat.yMMMd('en')
                                        .format(DateTime.parse(model.addedAt!)),
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: getRes(context, 15)),
                          Row(
                            children: [
                              Icon(
                                EneftyIcons.location_outline,
                                color: Colors.grey,
                                size: getRes(context, 20),
                              ),
                              SizedBox(
                                width: getRes(context, 10),
                              ),
                              SubtitleText(
                                model.location!,
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(height: getRes(context, 15)),
                          Row(
                            children: [
                              Icon(
                                Icons.call_split_sharp,
                                color: Colors.grey,
                                size: getRes(context, 20),
                              ),
                              SizedBox(
                                width: getRes(context, 10),
                              ),
                              SubtitleText(
                                model.categoryName! +
                                    ' > ' +
                                    model.subCategoryName!,
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ],
                          ),
                          //  SizedBox(height: getRes(context, 15)),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       top: getRes(context, 15),
                          //       bottom: getRes(context, 15)),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: DefaultButton(
                          //           onTap: () async {
                          //             // final Uri whatsappUri = Uri.parse(
                          //             //     'https://wa.me/${model.}');
                          //             // if (await canLaunchUrl(whatsappUri)) {
                          //             //   await launchUrl(whatsappUri);
                          //             // }
                          //           },
                          //           text: 'دردش',
                          //           color: backgroundContainer,
                          //           icon: EneftyIcons.message_2_outline,
                          //           iconSize: getRes(context, 22),
                          //           alignment: MainAxisAlignment.center,
                          //           isShadow: true,
                          //           borderColor: AppLightColors.primaryColor,
                          //           textColor: AppLightColors.primaryColor,
                          //         ),
                          //       ),
                          //       SizedBox(width: getRes(context, 15)),
                          //       Expanded(
                          //         child: DefaultButton(
                          //           onTap: () async {
                          //             // final Uri telUri =
                          //             //     Uri.parse('tel:${model.phonNumber}');
                          //             // if (await canLaunchUrl(telUri)) {
                          //             //   await launchUrl(telUri);
                          //             // }
                          //           },
                          //           icon: EneftyIcons.call_outline,
                          //           iconSize: getRes(context, 22),
                          //           alignment: MainAxisAlignment.center,
                          //           text: 'اتصل',
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: getRes(context, 8),
                  right: getRes(context, 8),
                  child: InkWell(
                    onTap: () {
                      HomeCubit.get(context).selectedWishlist(index);
                      HomeCubit.get(context).removeToWishlist(
                        index,
                        model.adId!,
                        fromWishlist: true,
                      );
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.redAccent.withOpacity(.8),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                if (cubit.actionWishlistLoading && cubit.wishlistIndex == index)
                  Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white, // ✅ لون الخلفية أبيض
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              getRes(context, 10)), // ✅ انحناء الحواف بمقدار 10
        ),
        title: Text(
          "تأكيد الحذف",
          style: TextStyle(fontFamily: 'Cairo-Reg'),
        ),
        content: Text(
          "هل أنت متأكد أنك تريد ازالة جميع العناصر من المفضلة؟",
          style: TextStyle(fontFamily: 'Cairo-Reg'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "إلغاء",
              style: TextStyle(fontFamily: 'Cairo-Reg'),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white, // ✅ لون الزر أحمر
              foregroundColor: AppLightColors.titleTextColor, // ✅ لون النص أبيض
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    getRes(context, 10)), // ✅ انحناء زر الخروج
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (HomeCubit.get(context).wishlistData.isNotEmpty) {
                Navigator.of(context).pop();
                HomeCubit.get(context).deleteAllWishList();
              } else {}
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red, // ✅ لون الزر أحمر
              foregroundColor: Colors.white, // ✅ لون النص أبيض
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    getRes(context, 10)), // ✅ انحناء زر الخروج
              ),
            ),
            child: Text(
              "موافق",
              style: TextStyle(fontFamily: 'Cairo-Reg'),
            ),
          ),
        ],
      ),
    );
  }
}
