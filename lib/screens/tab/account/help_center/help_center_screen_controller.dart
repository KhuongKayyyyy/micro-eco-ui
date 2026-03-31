import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:get/get.dart';

class HelpCenterScreenController extends GetxController {
  void goToCustomerService() {
    Get.toNamed(AppRoutes.customerService);
  }
}
