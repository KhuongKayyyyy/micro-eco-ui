import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigatorUtils {
  static Map<String, String>? _toRouteParameters(dynamic arguments) {
    if (arguments is! Map) return null;
    final parameters = <String, String>{};
    arguments.forEach((key, value) {
      final normalizedKey = key?.toString().trim();
      if (normalizedKey == null || normalizedKey.isEmpty) return;
      if (value == null) return;
      final normalizedValue = value.toString().trim();
      if (normalizedValue.isEmpty || normalizedValue.toLowerCase() == 'null') {
        return;
      }
      parameters[normalizedKey] = normalizedValue;
    });
    return parameters.isEmpty ? null : parameters;
  }

  static void goToScreen(
    BuildContext context,
    String route, {
    int? id,
    dynamic arguments,
  }) {
    final tabController = Get.find<TabScreenController>();
    final currentTabIndex = tabController.currentIndex.value;
    final currentTabNavigatorId =
        tabController.tabNavigatorIds[currentTabIndex];
    final parameters = _toRouteParameters(arguments);
    Get.toNamed(
      route,
      id: id ?? currentTabNavigatorId,
      arguments: arguments,
      parameters: parameters,
      preventDuplicates: false,
    );
  }
}
