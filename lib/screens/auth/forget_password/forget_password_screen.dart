import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/common/theme/theme_service.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/app_textfield.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/auth/forget_password/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends BaseScreen<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final isDarkMode = themeService.isDarkMode;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDarkMode ? AppColors.gray900 : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.gray900 : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? AppColors.gray200 : Colors.black87,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: context.tr("forgetPassword.title"),
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? AppColors.gray200 : AppColors.gray800,
              ),
              const SizedBox(height: 16),
              AppText(
                text: context.tr("forgetPassword.subtitle"),
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: isDarkMode ? AppColors.gray200 : AppColors.gray700,
              ),
              const SizedBox(height: 32),
              AppText(
                text: context.tr("signIn.email"),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? AppColors.gray200 : AppColors.primary,
              ),
              const SizedBox(height: 8),
              AppTextField(
                textController: controller.emailController,
                hintText: context.tr("signIn.email"),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => AppButton(
              disabled: !controller.isEmailValid.value,
              height: 60,
              text: context.tr('forgetPassword.sendCode'),
              onTap: controller.sendCode,
            ),
          ),
        ),
      ),
    );
  }
}
