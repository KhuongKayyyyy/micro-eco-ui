import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigatorUtils {
  static void goToScreen(BuildContext context, String route, {int? id}) {
    final tabController = Get.find<TabScreenController>();
    Get.toNamed(
      route,
      id: id ?? tabController.navigatorIdForTab(TabType.mentors),
    );
  }
}
