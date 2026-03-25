import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';

class AccountScreenController extends GetxController {
  final RxInt currentIndex = 0.obs;
  void goToMyDetail() {
    final tabController = Get.find<TabScreenController>();
    Get.toNamed(
      AppRoutes.myDetail,
      id: tabController.navigatorIdForTab(TabType.mentors),
    );
  }

  void logout() {}
}
