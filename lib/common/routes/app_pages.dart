import 'package:ecommerce_app/common/binding/tab_binding.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/screens/auth/forget_password/forget_password_controller.dart';
import 'package:ecommerce_app/screens/auth/forget_password/forget_password_screen.dart';
import 'package:ecommerce_app/screens/auth/otp/otp_screen.dart';
import 'package:ecommerce_app/screens/auth/otp/otp_screen_controller.dart';
import 'package:ecommerce_app/screens/auth/reset_password/reset_password_screen.dart';
import 'package:ecommerce_app/screens/auth/reset_password/reset_password_screen_controller.dart';
import 'package:ecommerce_app/screens/auth/sign_in/sign_in_controller.dart';
import 'package:ecommerce_app/screens/auth/sign_in/sign_in_screen.dart';
import 'package:ecommerce_app/screens/auth/sign_up/sign_up_screen.dart';
import 'package:ecommerce_app/screens/auth/sign_up/sign_up_screen_controller.dart';
import 'package:ecommerce_app/screens/notifications/notification_screen.dart';
import 'package:ecommerce_app/screens/notifications/notification_screen_controller.dart';
import 'package:ecommerce_app/screens/splash_screen.dart';
import 'package:ecommerce_app/screens/tab/tab_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    //splash screen
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),

    //auth pages
    GetPage(
      name: AppRoutes.signIn,
      page: () => SignInScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SignInController());
      }),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SignUpScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => ForgetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ForgetPasswordController());
      }),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => OtpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OtpScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ResetPasswordScreenController());
      }),
    ),

    //tab pages
    GetPage(
      name: AppRoutes.tabScreen,
      page: () => TabScreen(),
      binding: TabBinding(),
    ),

    //home pages
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => NotificationScreenController());
      }),
    ),
  ];
}
