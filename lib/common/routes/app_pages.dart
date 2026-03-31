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
import 'package:ecommerce_app/screens/tab/account/address_book/add_address_screen.dart';
import 'package:ecommerce_app/screens/tab/account/address_book/add_address_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/address_book/province_select_screen.dart';
import 'package:ecommerce_app/screens/tab/account/address_book/province_select_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/address_book/address_book_screen.dart';
import 'package:ecommerce_app/screens/tab/account/address_book/address_book_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/faq/fap_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/faq/faq_screen.dart';
import 'package:ecommerce_app/screens/tab/account/help_center/help_center_screen.dart';
import 'package:ecommerce_app/screens/tab/account/help_center/help_center_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/my_detail/my_detail_screen.dart';
import 'package:ecommerce_app/screens/tab/account/my_detail/my_detail_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/my_order_screen/my_order_screen.dart';
import 'package:ecommerce_app/screens/tab/account/my_order_screen/my_order_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/payment_method/add_new_card_screen.dart';
import 'package:ecommerce_app/screens/tab/account/payment_method/add_new_card_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/payment_method/payment_method_screen.dart';
import 'package:ecommerce_app/screens/tab/account/payment_method/payment_method_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/notifications/noti_setting_controller.dart';
import 'package:ecommerce_app/screens/tab/account/notifications/noti_setting_screen.dart';
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
    //account pages
    GetPage(
      name: AppRoutes.myDetail,
      page: () => MyDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyDetailScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.notiSetting,
      page: () => NotiSettingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => NotiSettingController());
      }),
    ),
    GetPage(
      name: AppRoutes.helpCenter,
      page: () => HelpCenterScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HelpCenterScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.faqs,
      page: () => FaqScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FaqScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.myOrders,
      page: () => MyOrderScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyOrderScreenController());
      }),
    ),

    GetPage(
      name: AppRoutes.addressBook,
      page: () => AddressBookScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddressBookScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.paymentMethods,
      page: () => const PaymentMethodScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PaymentMethodScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.addAddress,
      page: () => AddAddressScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddAddressScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.provinceSelect,
      page: () => ProvinceSelectScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProvinceSelectScreenController());
      }),
    ),

    GetPage(
      name: AppRoutes.paymentMethods,
      page: () => PaymentMethodScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PaymentMethodScreenController());
      }),
    ),
    GetPage(
      name: AppRoutes.addNewCard,
      page: () => AddNewCardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddNewCardScreenController());
      }),
    ),
  ];
}
