import 'package:ajder_project/ajdar_app/data/model/home/ads_home_model.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/colors/app_colors.dart';
import 'package:ajder_project/ajdar_app/ui/pages/ads_page/ads_details_page/ads_details_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/sign_up_page/sign_up_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/souq/section_details_page/section_details_page.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/app_circle_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
// import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/image_background_container.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/route_animation.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../conest.dart';
import '../../../confirm/theme/shadow_theme.dart';
import '../../../confirm/theme/sub_theme_data.dart';
import '../../design/dimensions/app_dimensions.dart';

Widget adsItem(context,
    {required AdsHomeModel model, required int index, bool isMe = false}) {
  final dynamic imageUrl = model.imageUrl;

  return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);

          return Padding(
            padding: EdgeInsets.only(
                bottom: getRes(context, 10),
                left: getRes(context, 15),
                right: getRes(context, 15)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CustomPageTransition.createRoute(
                        page: AdsDetailsPage(
                          id: model.id!,
                        ),
                        isBack: true));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getRes(context, 10),
                    vertical: getRes(context, 10)),
                decoration: BoxDecoration(
                    color: backgroundContainer,
                    border: Border.all(
                      color: Colors.grey[200]!,
                    ),
                    borderRadius: BorderRadius.circular(getRes(context, 10)),
                    boxShadow: [
                      ShadowTheme().switchThemeShadow,
                    ]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          // height: 150,
                          // width: 150,
                          // color: Colors.amber,
                          child: ImageBackgroundContainer(
                            isNetwork: imageUrl.isNotEmpty,
                            network: imageUrl,
                            backgroundColor: Colors.transparent,
                            height: getRes(context, 120),
                            width: getRes(context, 120),
                            radius: BorderRadius.circular(
                              getRes(context, 10),
                            ),
                          ),
                        ),
                        SizedBox(width: getRes(context, 10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(
                                model.title!,
                                fontSize: 14,
                              ),

                              SizedBox(height: getRes(context, 5)),
                              // DescriptionText(model.description!),
                              // Wrap(
                              //   spacing: getRes(context, 3),
                              //   runSpacing: getRes(context, 5),
                              //   children:
                              //       List.generate(model.adFieldDtos!.length, (index) {
                              //     return Container(
                              //       padding: EdgeInsets.all(getRes(context, 5)),
                              //       decoration: BoxDecoration(
                              //         color: Colors.grey[100],
                              //         borderRadius:
                              //             BorderRadius.circular(getRes(context, 10)),
                              //       ),
                              //       child: SmallText(model.adFieldDtos![index].value!),
                              //     );
                              //   }),
                              // ),

                              if (model.location != null &&
                                  model.location!.isNotEmpty)
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: getRes(context, 10)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        EneftyIcons.location_outline,
                                        color: bodyTextThemeColor,
                                        size: getRes(context, 16),
                                      ),
                                      SizedBox(width: getRes(context, 5)),
                                      SmallText('${model.location}'),
                                    ],
                                  ),
                                ),
                              SizedBox(
                                height: getRes(context, 7),
                              ),
                              SmallText(dateTimeHandle(model.createdAt!)),

                              Padding(
                                padding: EdgeInsets.only(
                                    top: getRes(context, 15),
                                    right: getRes(context, 5)),
                                child: Row(
                                  children: [
                                    TitleText(
                                      "${priceValue(model.price)}\$",
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                    Spacer(),
                                    if (!isMe)
                                      AppCircleButton(
                                        onTap: () {
                                          if (box.read('token') == null) {
                                            showLoginDialog(context);
                                          } else {
                                            print(cubit.ads.length);
                                            if (cubit.isWishlist[index]) {
                                              cubit.removeToWishlist(
                                                  index, model.id!);
                                            } else {
                                              cubit.addToWishlist(
                                                  index, model.id!);
                                            }
                                          }
                                        },
                                        child: (cubit.actionWishlistLoading &&
                                                cubit.addIndex == index)
                                            ? SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: 2),
                                              )
                                            : Icon(
                                                cubit.isWishlist[index]
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.redAccent,
                                              ),
                                      ),
                                  ],
                                ),
                              ),
                              // SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: getRes(context, 15),
                          bottom: getRes(context, 15)),
                      child: Row(
                        children: [
                          Expanded(
                            child: DefaultButton(
                              onTap: () async {
                                final Uri whatsappUri = Uri.parse(
                                    'https://wa.me/${model.phonNumber}');
                                if (await canLaunchUrl(whatsappUri)) {
                                  await launchUrl(whatsappUri);
                                }
                              },
                              // text: 'دردش',
                              color: backgroundContainer,
                              // icon: EneftyIcons.message_2_outline,
                              // iconSize: getRes(context, 22),
                              // alignment: MainAxisAlignment.center,
                              isShadow: true,
                              borderColor: Colors.green,
                              textColor: Colors.green,
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
                                    'دردش',
                                    fontSize: 14,
                                    color: Colors.green,
                                    weight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: getRes(context, 15)),
                          Expanded(
                            child: DefaultButton(
                              onTap: () async {
                                final Uri telUri =
                                    Uri.parse('tel:${model.phonNumber}');
                                if (await canLaunchUrl(telUri)) {
                                  await launchUrl(telUri);
                                }
                              },
                              icon: EneftyIcons.call_outline,
                              iconSize: getRes(context, 22),
                              alignment: MainAxisAlignment.center,
                              text: 'اتصل',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
}

void showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      bool obscurePassword = true;
      final _formKey = GlobalKey<FormState>(); // مفتاح الفورم للتالي

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is AuthLoginSuccessState) {
                  box.write('token', state.loginData['accessToken']);
                  // box.put('user', state.data['user']);
                  print(box.read('token'));
                  Navigator.pop(context);
                  HomeCubit.get(context).getAds(
                    isRefresh: true,
                    sectionName: HomeCubit.get(context)
                        .sections[HomeCubit.get(context).sectionIndex!]
                        .id,
                  );

                  CustomSnackbar.show(
                    context: context,
                    message: 'تم تسجيل الدخول بنجاح!',
                    type: SnackbarType.success,
                    // icon: Icons.check_circle,
                    // backgroundColor: Colors.green,
                  );
                }
                if (state is AuthLoginErrorState) {
                  CustomSnackbar.show(
                    context: context,
                    message:
                        'حدث خطأ في تسجيل الدخول تحقق من الاتصال بالانترنت',
                    // icon: Icons.close,
                    // backgroundColor: /Colors.redAccent,
                    type: SnackbarType.error,
                  );
                }
                if (state is AuthLoginErrorConnectState) {
                  CustomSnackbar.show(
                    context: context,
                    message: 'حدث خطأ ما, تحقق من الاتصال بالانترنت',
                    // icon: Icons.close,
                    // backgroundColor: Colors.redAccent,
                    type: SnackbarType.error,
                  );
                }
              }, builder: (context, state) {
                return BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    AuthCubit cubit = AuthCubit.get(context);
                    return SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مرحبا بعودتك',
                              style: TextStyle(
                                fontSize: getRes(context, 22),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: getRes(context, 8)),
                            Text(
                              'سجل الدخول للتفاعل واضافة اعلاناتك',
                              style: TextStyle(
                                  fontSize: getRes(context, 16),
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(height: getRes(context, 24)),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'البريد الالكتروني',
                                style: TextStyle(
                                    fontSize: getRes(context, 14),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: getRes(context, 5)),
                            TextFormField(
                              controller: cubit.phoneLogin,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'أدخل بريدك الالكتروني',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      getRes(context, 10)),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'يرجى إدخال البريد الالكتروني';
                                }
                                // إضافة شرط للتحقق من صحة رقم الهاتف إن رغبت
                                return null;
                              },
                            ),
                            SizedBox(height: getRes(context, 16)),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'كلمة المرور',
                                style: TextStyle(
                                    fontSize: getRes(context, 14),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: getRes(context, 5)),
                            TextFormField(
                              controller: cubit.passwordLogin,
                              obscureText: obscurePassword,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                ),
                                hintText: 'أدخل كلمة المرور',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      getRes(context, 10)),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'يرجى إدخال كلمة المرور';
                                } else if (value.trim().length < 8) {
                                  return 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: getRes(context, 24)),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.loginConnect();
                                    // إذا كانت البيانات صحيحة، نفذ تسجيل الدخول
                                    // يمكنك إضافة الكود المناسب هنا لتسجيل الدخول
                                  }
                                  if (state is AuthLoginLoadingState) {
                                    return;
                                  }
                                },
                                label: state is AuthLoginLoadingState
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'تسجيل الدخول',
                                      ),
                                icon: Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppLightColors.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: getRes(context, 14)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        getRes(context, 10)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getRes(context, 10),
                            ),
                            Row(
                              children: [
                                SubtitleText('ليس لديك حساب؟  '),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CustomPageTransition.createRoute(
                                              page: SignUpPage(),
                                              isModal: true));
                                    },
                                    child: Text('سجل الان'))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          );
        },
      );
    },
  );
}
