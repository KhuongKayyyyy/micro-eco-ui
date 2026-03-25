import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';

class HomeScreenController extends GetxController {
  void navigateToNotificationScreen() {
    final tabController = Get.find<TabScreenController>();
    Get.toNamed(
      AppRoutes.notification,
      id: tabController.navigatorIdForTab(TabType.home),
    );
  }
}
