import 'dart:async';

import 'package:ecommerce_app/common/services/secure_storage_service.dart';
import 'package:ecommerce_app/common/theme/theme_service.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppColors.gray800
                            : AppColors.gray100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 44,
                        color: isDarkMode
                            ? AppColors.gray100
                            : AppColors.primary,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      duration: 350.ms,
                    )
                    .then()
                    .shake(hz: 3, duration: 400.ms),
                const SizedBox(height: 16),
                AppText(
                      text: 'SKKU EMBA',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColors.gray100 : AppColors.gray900,
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .fadeIn(duration: 350.ms, delay: 150.ms)
                    .moveY(begin: 8, end: 0, duration: 350.ms),
                const SizedBox(height: 6),
                AppText(
                      text: 'Loading your experience...',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDarkMode ? AppColors.gray500 : AppColors.gray600,
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .fadeIn(duration: 350.ms, delay: 250.ms)
                    .moveY(begin: 6, end: 0, duration: 300.ms),
                const SizedBox(height: 24),
                SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDarkMode ? AppColors.gray100 : AppColors.primary,
                        ),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat())
                    .fadeIn(duration: 300.ms, delay: 350.ms)
                    .shimmer(duration: 1200.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
