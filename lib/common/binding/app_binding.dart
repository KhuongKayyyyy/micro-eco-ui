import 'package:ecommerce_app/common/theme/theme_service.dart';
import 'package:ecommerce_app/screens/auth/sign_in/sign_in_controller.dart';
import 'package:ecommerce_app/screens/tab/account/account_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/cart/cart_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/favorite/favorite_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/search/search_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeService().init(), fenix: true);

    //home tab
    Get.lazyPut(() => TabScreenController(), fenix: true);
    Get.lazyPut(() => HomeScreenController(), fenix: true);
    Get.lazyPut(() => SearchScreenController(), fenix: true);
    Get.lazyPut(() => FavoriteScreenController(), fenix: true);
    Get.lazyPut(() => CartScreenController(), fenix: true);
    Get.lazyPut(() => AccountScreenController(), fenix: true);

    //auth
    Get.lazyPut(() => SignInController(), fenix: true);
  }
}
