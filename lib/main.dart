import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/common/binding/app_binding.dart';
import 'package:ecommerce_app/common/routes/app_pages.dart';
import 'package:ecommerce_app/common/services/app_size.dart';
import 'package:ecommerce_app/common/theme/theme_service.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/constants/app_theme.dart';
import 'package:ecommerce_app/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // FCM 초기화
  // final FcmService fcmService = FcmService();
  // await fcmService.initialize();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize theme service before app start
  await Get.putAsync(() async => ThemeService().init());

  final runnableApp = _buildRunnableApp(
    isWeb: kIsWeb,
    webAppWidth: 750.0,
    app: const MyApp(),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi'), Locale('ko')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: runnableApp,
    ),
  );
}

Widget _buildRunnableApp({
  required bool isWeb,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: SizedBox(width: webAppWidth, child: app),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static void _initLoadingIndicator() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = AppColors.gray900
      ..boxShadow = [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.22),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ]
      ..indicatorColor = AppColors.statusSuccess
      ..progressColor = AppColors.statusSuccess
      ..maskType = EasyLoadingMaskType.black
      ..textColor = AppColors.white
      ..textStyle = const TextStyle(
        fontFamily: 'Pretendard',
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.35,
      )
      ..radius = 12
      ..lineWidth = 3
      ..dismissOnTap = false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _initLoadingIndicator();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기
        },
        child: Obx(() {
          final ThemeService themeService = Get.find<ThemeService>();
          return GetMaterialApp(
            initialRoute: AppRoutes.splash,
            getPages: AppPages.pages,
            initialBinding: AppBinding(),
            title: 'Micro Ecommerce',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeService.themeModeRx.value,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: EasyLoading.init(
              builder: (context, child) {
                AppSize.init(context);

                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: child!,
                );
              },
            ),
            home: const SplashScreen(),
          );
        }),
      ),
    );
  }
}
