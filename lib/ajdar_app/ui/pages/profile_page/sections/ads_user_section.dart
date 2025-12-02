import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/pages/about_us_page/aboute_us_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/edit_photo_user_page/edit_photo_user_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/photo_user_page/photo_user_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/privacy_policy/privacy_policy.dart';
import 'package:ajder_project/ajdar_app/ui/pages/wishlist_page/wishlist_page.dart';
// import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/ads_item_widget.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/image_background_container.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../confirm/theme/shadow_theme.dart';
import '../../../../confirm/theme/sub_theme_data.dart';
import '../../../design/dimensions/app_dimensions.dart';
import '../../../widgets/custom_widgets/custom_button.dart';
import '../../../widgets/custom_widgets/my_dropdown.dart';
import '../../../widgets/custom_widgets/my_text_field.dart';
import '../../../widgets/custom_widgets/route_animation.dart';
import '../../account_settings_page/account_settings_page.dart';

class MyAdsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Container(
      //   width: MediaQuery.of(context).size.width -
      //       (MediaQuery.of(context).size.width * .27),
      //   decoration: BoxDecoration(
      //     color: backgroundContainer,
      //     gradient: LinearGradient(colors: [
      //       Colors.grey[100]!,
      //       Colors.white,
      //     ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      //     borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(getRes(context, 50))),
      //   ),
      //   child: Container(
      //     child: SideDrawerComponents(),
      //   ),
      // ), // قائمة جانبية
      appBar: AppBar(
        title: Text(
          "اعلاناتي",
          style: TextStyle(fontSize: getRes(context, 17)),
        ),
        backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(top: getRes(context, 16)),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [MyAdsItemSection()],
      ),
    );
  }
}

class MyAdsItemSection extends StatelessWidget {
  const MyAdsItemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return itemHandle(context, cubit: cubit);
      },
    );
  }

  Widget itemHandle(context, {required HomeCubit cubit}) {
    if (cubit.userAdsLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (cubit.userAds.isNotEmpty) {
      return adsItemSection(context, cubit: cubit);
    } else {
      return noItemFound();
    }
  }

  Center noItemFound() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
          SizedBox(height: 10),
          Text(
            "No ads found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text(
            "Get started by creating your first ad.",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget adsItemSection(context, {required HomeCubit cubit}) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: cubit.userAds.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            child: adsItem(
              context,
              model: cubit.userAds[index],
              index: index,
              isMe: true,
            ),
          );
        },
      ),
    );
  }
}

class AdsFilterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: getRes(context, 20),
        left: getRes(context, 5),
        right: getRes(context, 5),
        bottom: getRes(context, 20),
      ),
      decoration: BoxDecoration(
        color: backgroundContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [ShadowTheme().switchThemeShadow],
      ),
      // elevation: 6,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // Search
          MyTextField(
            hint: 'بحث عن عنوان, وصف, الخ ...',
            controller: TextEditingController(),
            label: 'بحث عن اعلانات',
          ),

          SizedBox(height: getRes(context, 15)),
          MyDropdown(
            label: 'الحالات',
            selectValue: 'جميع الحالات',
            values: ['جميع الحالات'],
          ),

          // Status Dropdown
          // DropdownButtonFormField<String>(
          //   decoration: InputDecoration(
          //     labelText: 'Status',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          //   items: ['All Status']
          //       .map((status) =>
          //           DropdownMenuItem(value: status, child: Text(status)))
          //       .toList(),
          //   onChanged: (value) {},
          //   value: 'All Status',
          // ),
          SizedBox(height: getRes(context, 15)),
          MyDropdown(
            label: 'ترتيب حسب',
            selectValue: 'تاريخ الانشاء',
            values: ['تاريخ الانشاء'],
          ),

          // Sort By Dropdown
          SizedBox(height: getRes(context, 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getRes(context, 8)),
                  ),
                ),
                icon: Icon(Icons.arrow_downward),
                label: Text("Descending"),
                onPressed: () {},
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getRes(context, 5),
                      vertical: getRes(context, 6),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(getRes(context, 8)),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.view_list, color: Colors.blue),
                        SizedBox(width: getRes(context, 6)),
                        Icon(Icons.grid_view_outlined, color: Colors.grey),
                        SizedBox(width: getRes(context, 6)),
                        Icon(Icons.print_outlined, color: Colors.grey),
                      ],
                    ),
                  ),
                  SizedBox(width: getRes(context, 10)),
                  Column(
                    children: [
                      Text("0", style: TextStyle(color: Colors.grey[600])),
                      Text("of", style: TextStyle(color: Colors.grey[600])),
                      Text("0", style: TextStyle(color: Colors.grey[600])),
                      Text("ads", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SideDrawerComponents extends StatelessWidget {
  const SideDrawerComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: getRes(context, 25)),
            child: Column(
              // padding: EdgeInsets.symmetric(vertical: getRes(context, 30)),
              children: [
                ImageUserSection(cubit: cubit),
                SizedBox(height: getRes(context, 20)),
                ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleText(cubit.meData!.userName!),
                      SizedBox(width: getRes(context, 10)),
                      Container(
                        height: getRes(context, 30),
                        width: getRes(context, 30),
                        decoration: BoxDecoration(
                          color: Colors.green[100]!.withOpacity(.4),
                          shape: BoxShape.circle,
                        ),

                        // onPressed: () {},
                        child: Icon(
                          Icons.edit,
                          size: getRes(context, 20),
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getRes(context, 10)),
                  DescriptionText(cubit.meData!.email!),
                  SizedBox(height: getRes(context, 20)),
                ],
                ...[
                  MyListTail(
                    // selected: true,
                    // titleTextStyle: TextStyle(fontSize: getRes(context, 16)),
                    onTap: () {
                      Navigator.pop(context);
                      // ScaffoldMessenger.of(context).;
                      // Navigator.push(
                      //     context,
                      //     CustomPageTransition.createRoute(
                      //         page: WishlistPage(), isHeroStyle: true));
                    },
                    leading: Icon(Icons.save, color: Color(0xFF333333)),
                    subtitle: Text('اعلاناتي'),
                  ),
                  MyListTail(
                    onTap: () {
                      // cubit.selectPage(3);
                      Navigator.push(
                        context,
                        CustomPageTransition.createRoute(
                          page: WishlistPage(),
                          isHeroStyle: true,
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.favorite_sharp,
                      color: Color(0xFF333333),
                    ),
                    subtitle: Text('المفضلة'),
                  ),
                  MyListTail(
                    onTap: () {
                      Navigator.push(
                        context,
                        CustomPageTransition.createRoute(
                          page: AccountSettingsPage(),
                          isHeroStyle: true,
                        ),
                      );
                    },
                    leading: Icon(Icons.settings, color: Color(0xFF333333)),
                    subtitle: Text('اعدادات الحساب'),
                  ),
                  MyListTail(
                    onTap: () {},
                    leading: Icon(
                      Icons.miscellaneous_services,
                      color: Color(0xFF333333),
                    ),
                    subtitle: Text('الدعم الفني'),
                  ),
                  MyListTail(
                    onTap: () {},
                    leading: Icon(
                      Icons.notifications,
                      color: Color(0xFF333333),
                    ),
                    subtitle: Text('الاشعارات'),
                  ),
                  Divider(),
                  MyListTail(
                    onTap: () {
                      Navigator.push(
                        context,
                        CustomPageTransition.createRoute(
                          page: AboutUsPage(),
                          isHeroStyle: true,
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.error_outline,
                      color: Color(0xFF333333),
                    ),
                    subtitle: Text('حول التطبيق'),
                  ),
                  MyListTail(
                    onTap: () {
                      Navigator.push(
                        context,
                        CustomPageTransition.createRoute(
                          page: PrivacyPolicy(),
                          isHeroStyle: true,
                        ),
                      );
                    },
                    leading: Icon(Icons.security, color: Color(0xFF333333)),
                    subtitle: SubtitleText('سياسة الخصوصية'),
                  ),
                  // MyListTail(
                  //   leading: Icon(Icons.home),
                  //   title: Text('العودة للرئيسية'),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: DefaultButton(
                      alignment: MainAxisAlignment.center,
                      onTap: () {},
                      text: 'تسجيل الخروج',
                      icon: Icons.logout,
                      iconSize: 20,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class ImageUserSection extends StatelessWidget {
  ImageUserSection({super.key, required this.cubit});
  HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 50,
      // color: Colors.black,
      // height: 50,
      decoration: BoxDecoration(boxShadow: [ShadowTheme().switchThemeShadow]),
      child: InkWell(
        onTap: () {
          showImageOptions(context);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(radius: 53, backgroundColor: Colors.white),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.amber,
              child: ImageBackgroundContainer(
                isNetwork: cubit.meData != null,
                network: cubit.meData!.imageUrl,
                isCircle: true,
                height: 100,
                width: 100,
              ),
            ),
            Positioned(
              right: getRes(context, 5),
              bottom: getRes(context, 5),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(radius: 14, backgroundColor: Colors.white),
                  CircleAvatar(radius: 11, backgroundColor: Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showImageOptions(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: getRes(context, 10)),
          height: getRes(context, 200),
          decoration: BoxDecoration(
            // color:
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(getRes(context, 25)),
              // top: getRes(context, size)
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: getRes(context, 20)),
              Container(
                height: getRes(context, 4),
                width: getRes(context, 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getRes(context, 10)),
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: getRes(context, 20)),
              MyListTail(
                leading: Icon(Icons.photo_outlined),
                subtitle: Text('عرض صورة الملف الشخصي'),
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: PhotoUserPage(),
                      isBack: true,
                    ),
                  );
                },
              ),
              SizedBox(height: getRes(context, 10)),
              MyListTail(
                leading: Icon(Icons.add_photo_alternate_outlined),
                subtitle: Text('تعديل صورة الملف الشخصي'),
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                      page: EditPhotoUserPage(),
                      isBack: true,
                    ),
                  );
                  // AuthCubit.get(context).getImage(source: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyListTail extends StatelessWidget {
  MyListTail({
    super.key,
    required this.leading,
    required this.subtitle,
    required this.onTap,
  });
  Widget leading;
  Widget subtitle;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: getRes(context, 20),
        right: getRes(context, 15),
        left: getRes(context, 15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            leading,
            SizedBox(width: getRes(context, 15)),
            subtitle,
          ],
        ),
      ),
    );
  }
}
