import 'package:ecommerce_app/screens/tab/account/account_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/cart/cart_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/favorite/favorite_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/search/search_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:get/get.dart';

class TabBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TabScreenController());
    Get.put(HomeScreenController());
    Get.put(SearchScreenController());
    Get.put(FavoriteScreenController());
    Get.put(CartScreenController());
    Get.put(AccountScreenController());
  }
}
