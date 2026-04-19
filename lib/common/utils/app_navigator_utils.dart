import 'package:ecommerce_app/common/services/navigation_payload_store.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigatorUtils {
  static Map<String, String>? _normalizeRouteParameters(dynamic parameters) {
    if (parameters is! Map) return null;
    final normalizedParameters = <String, String>{};
    for (final entry in parameters.entries) {
      final key = entry.key;
      final value = entry.value;
      final normalizedKey = key?.toString().trim();
      if (normalizedKey == null || normalizedKey.isEmpty) continue;
      if (value == null) continue;
      final normalizedValue = value.toString().trim();
      if (normalizedValue.isEmpty || normalizedValue.toLowerCase() == 'null') {
        continue;
      }
      normalizedParameters[normalizedKey] = normalizedValue;
    }
    return normalizedParameters.isEmpty ? null : normalizedParameters;
  }

  static void goToScreen(
    BuildContext context,
    String route, {
    int? id,
    dynamic parameters,
  }) {
    final tabController = Get.find<TabScreenController>();
    final currentTabIndex = tabController.currentIndex.value;
    final currentTabNavigatorId =
        tabController.tabNavigatorIds[currentTabIndex];
    final routeParameters = _normalizeRouteParameters(parameters);
    if (routeParameters != null && routeParameters.isNotEmpty) {
      Get.find<NavigationPayloadStore>().save(route, routeParameters);
    }
    Get.toNamed(
      route,
      id: id ?? currentTabNavigatorId,
      parameters: routeParameters,
      preventDuplicates: false,
    );
  }
}
