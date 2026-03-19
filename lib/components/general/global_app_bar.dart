import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalAppBar extends StatelessWidget {
  final String title;

  const GlobalAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(text: title, fontSize: 32, fontWeight: FontWeight.w700),
      centerTitle: false,
      titleSpacing: 0,
      actions: [
        IconButton(
          onPressed: () {
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
