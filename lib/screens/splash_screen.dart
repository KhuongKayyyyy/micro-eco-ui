import 'dart:async';

import 'package:ecommerce_app/common/services/secure_storage_service.dart';
import 'package:ecommerce_app/common/theme/theme_service.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  final SecureStorageService _storage = SecureStorageService();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      final accessToken = await _storage.get(SecureStorageKey.accessToken);

      // If there is no token, navigate to the login screen
      if (accessToken == null) {
        Get.offAllNamed(AppRoutes.signIn);
      } else {
        try {
          // to do
        } catch (_) {}
        Get.offAllNamed(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final isDarkMode = themeService.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.gray900 : Colors.white,
      body: SafeArea(child: Container()),
    );
  }
}
