import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  bool isTitleCenter;
  final TabType? tabType;

  GlobalAppBar({
    super.key,
    required this.title,
    this.tabType,
    this.isTitleCenter = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: AppText(text: title, fontSize: 26, fontWeight: FontWeight.w700),
      ),
      centerTitle: isTitleCenter,
      titleSpacing: 0,
      actions: [
        IconButton(
          onPressed: () {
            if (tabType != null && Get.isRegistered<TabScreenController>()) {
              final tabController = Get.find<TabScreenController>();
              Get.toNamed(
                AppRoutes.notification,
                id: tabController.navigatorIdForTab(tabType!),
              );
              return;
            }
            Get.toNamed(AppRoutes.notification);
          },
          icon: Icon(
            Icons.notifications_none_outlined,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
