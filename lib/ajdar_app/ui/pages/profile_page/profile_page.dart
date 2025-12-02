import 'package:ajder_project/ajdar_app/domain/app_cubit/app_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/app_cubit/app_state.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/login_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/profile_page/sections/profile_body_section.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_snack_bar.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/home_cubit/home_state.dart';
import '../../design/colors/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    HomeCubit cubit = HomeCubit.get(context);
    cubit.getUserAds(
      isUser: true,
      isRefresh: true,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is LogoutSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  context,
                  title: 'تسجيل الخروج',
                  message: 'تم تسجيل الخروج بنجاح',
                  backgroundColor: AppLightColors.titleTextColor,
                ),
              );
              box.remove('token');

              box.remove('completeAuth');
            }
          },
          builder: (context, state) {
            return BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return HomeCubit.get(context).token == ''
                        ? LoginPage()
                        : Scaffold(
                            appBar: AppBar(
                              title: Text('الملف الشخصي'),
                            ),
                            body: SafeArea(
                              child: Container(
                                child: HomeCubit.get(context).meLoading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ProfileBodySection(),
                              ),
                            ),
                          );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
