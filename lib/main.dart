import 'package:ajder_project/ajdar_app/confirm/theme/light_theme.dart';
// import 'package:ajder_project/ajdar_app/data/model/message_model.dart';
// import 'package:ajder_project/ajdar_app/data/model/notification_model.dart';
import 'package:ajder_project/ajdar_app/domain/app_cubit/app_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/app_cubit/app_state.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/services/local_notificaion_services.dart';
import 'package:ajder_project/ajdar_app/services/notification_services.dart';
// import 'package:ajder_project/ajdar_app/ui/pages/auth/otp_page/otp_page.dart';
// import 'package:ajder_project/ajdar_app/ui/layout/home/home_layout.dart';
// import 'package:ajder_project/ajdar_app/ui/pages/auth/login_page/login_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/splash_screen/splash_screen.dart';
import 'package:ajder_project/conest.dart';
import 'package:ajder_project/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'ajdar_app/confirm/theme/dark_theme.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
  // await signalRService.initConnections();

  runApp(AjdarApp());
}

final signalRService = SignalRService(
  baseUrl: 'https://api.syriaopenstore.com', // رابط السيرفر
  tokenProvider: () async {
    // هنا ارجع التوكن الخاص بالمستخدم
    return 'Bearer ${box.read('token')}';
  },
);

class AjdarApp extends StatefulWidget {
  AjdarApp({
    super.key,
  });

  @override
  State<AjdarApp> createState() => _AjdarAppState();
}

class _AjdarAppState extends State<AjdarApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // if (box.read('token') != null) {
    //   signalRService.stopConnections().then((value) {
    //     signalRService.initConnections().then((_) {
    //       print("SignalR Connected!");
    //     });
    //   });
    // }
  }

  @override
  void dispose() {
    signalRService.stopConnections();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('token: ${box.read('token')}');

    // box.remove('token');

    // box.write('token',
    //     'eyJhbGciOiJIUzI1NiIsImtpZCI6ImFjY2Vzcy1rZXktb3BlblN5cmlhLXN0b3IiLCJ0eXAiOiJKV1QifQ.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiS2hhbGlkYW8iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJraGFsaWQubW9oLnpvdWJpQGdtYWlsLmNvbSIsInN1YiI6IjgyOTNhNjI5LWJlYmQtNDhkMi02NDhjLTA4ZGRlOWY2OWVlMSIsImp0aSI6Ijg4NGNjNzUzLWM4OGQtNGI5Yy1iNTQ0LWY3YjJhOWU3ZTdkYyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlVzZXIiLCJleHAiOjE3NTczNzI0OTcsImlzcyI6Imh0dHBzOi8vYXBpLnN5cmlhb3BlbnN0b3JlLmNvbSIsImF1ZCI6Imh0dHBzOi8vc3lyaWFvcGVuc3RvcmUuY29tLyJ9.AsqGqI5MJtD6q3xH68WofL8p8kbcAQJPBl5qp9eKj9Y');
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit()
            ..sectionConnect()
            ..sliderConnect(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: Locale('ar'),

            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: LightTheme().buildLightTheme,
            darkTheme: DarkTheme().buildDarkTheme,
            // themeMode: ThemeMode.dark,
            themeMode: AppCubit.get(context).theme,
            // home: CustomerStartPage().page,
            // home: OtpPage(),
            home: SplashScreen(),
            // home: HomePage(),
          );
        },
      ),
    );
  }
}
