import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  void navigateToNotificationScreen() {
    Get.toNamed(AppRoutes.notification);
  }
}
