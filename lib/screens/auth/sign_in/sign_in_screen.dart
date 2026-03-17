import 'package:ecommerce_app/common/theme/theme_service.dart';
import 'package:ecommerce_app/components/auth/facebook_login_button.dart';
import 'package:ecommerce_app/components/auth/google_login_button.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/app_textfield.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/auth/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class SignInScreen extends BaseScreen<SignInController> {
  const SignInScreen({super.key});

  ///
  /// Init
  ///
  @override
  void onInit(BuildContext context) {
    super.onInit(context);
    // Reset form when returning to sign in screen - defer to after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetFormForNewLogin();
    });
  }

  ///
  /// Dispose
  ///
  @override
  void onDispose(BuildContext context) {
    super.onDispose(context);
  }

  ///
  /// 화면 본문
  ///
  @override
  Widget buildBody(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final isDarkMode = themeService.isDarkMode;
    const bottomBarHeight = 64.0;

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
                text: context.tr("signIn.title"),
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? AppColors.gray200 : AppColors.gray800,
              ),
              AppText(
                text: context.tr("signIn.subtitle"),
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: isDarkMode ? AppColors.gray200 : AppColors.gray700,
              ),
              const SizedBox(height: 32),
              _buildEmailLoginSection(context, isDarkMode),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Obx(
                  () => AppButton(
                    height: 60,
                    borderRadius: 12,
                    text: context.tr('signIn.login'),
                    onTap: controller.isLoginEnabled.value
                        ? () => controller.signInWithEmail()
                        : () {},
                    width: double.infinity,
                    color: controller.isLoginEnabled.value
                        ? Colors.black
                        : (isDarkMode ? AppColors.gray600 : AppColors.gray500),
                  ),
                ),
              ),
              _buildDivision(context),
              const SizedBox(height: 30),
              _buildSocialLoginSection(context),
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: SizedBox(
          height: bottomBarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.gotoSignUp,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: context.tr('signIn.noAccount'),
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.gray300
                              : AppColors.gray700,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: context.tr('signIn.join'),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivision(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final isDarkMode = themeService.isDarkMode;
    final dividerColor = isDarkMode ? AppColors.gray700 : AppColors.gray300;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: dividerColor, thickness: 1, height: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AppText(
              text: context.tr('signIn.or'),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDarkMode ? AppColors.gray300 : AppColors.gray500,
            ),
          ),
          Expanded(
            child: Divider(color: dividerColor, thickness: 1, height: 1),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailLoginSection(BuildContext context, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          enableBorderColor: Colors.black,
          hintText: context.tr('signIn.email'),
          textController: controller.emailController,
        ),
        const SizedBox(height: 20),
        AppTextField(
          enableBorderColor: Colors.black,
          hintText: context.tr('signIn.password'),
          textController: controller.passwordController,
          obscureText: true,
        ),
        TextButton(
          onPressed: () {
            controller.gotoForgetPassword();
          },
          child: AppText(
            color: Colors.black,
            text: context.tr('signIn.forgotPassword'),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginSection(BuildContext context) {
    return Column(
      children: [
        GoogleLoginButton(onTap: () {}),
        const SizedBox(height: 20),
        FacebookLoginButton(onTap: () {}),
      ],
    );
  }
}
