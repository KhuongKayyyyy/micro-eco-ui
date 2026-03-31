import 'package:ecommerce_app/common/utils/app_navigator_utils.dart';
import 'package:ecommerce_app/components/dialog/log_out_dialog.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:get/get.dart';

class AccountScreenController extends GetxController {
  final RxInt currentIndex = 0.obs;
  void goToMyDetail() {
    AppNavigatorUtils.goToScreen(Get.context!, AppRoutes.myDetail);
  }

  void logout() {
    Get.dialog(LogOutDialog());
  }

  void goToNotiSetting() {
    AppNavigatorUtils.goToScreen(Get.context!, AppRoutes.notiSetting);
  }

  void goToHelpCenter() {
    AppNavigatorUtils.goToScreen(Get.context!, AppRoutes.helpCenter);
  }

  void goToFaqs() {
    AppNavigatorUtils.goToScreen(Get.context!, AppRoutes.faqs);
  }

  void goToMyOrders() {
    AppNavigatorUtils.goToScreen(Get.context!, AppRoutes.myOrders);
  }

  void goToAddressBook() {
    Get.toNamed(AppRoutes.addressBook, id: null);
  }

  void goToPaymentMethods() {
    Get.toNamed(AppRoutes.paymentMethods, id: null);
  }
}
