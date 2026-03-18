import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/app_textfield.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/auth/reset_password/reset_password_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ResetPasswordScreen extends BaseScreen<ResetPasswordScreenController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: context.tr('resetPassword.title'),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.gray900,
              ),
              const SizedBox(height: 8),
              AppText(
                text:
                    'Set the new password for your account so you can login and access all the features.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6E7285),
              ),
              const SizedBox(height: 32),
              AppTextField(
                labelText: context.tr('resetPassword.password'),
                hintText: context.tr('resetPassword.passwordHint'),
                textController: controller.newPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              AppTextField(
                labelText: context.tr('resetPassword.confirmPassword'),
                hintText: context.tr('resetPassword.confirmPasswordHint'),
                textController: controller.confirmPasswordController,
                obscureText: true,
              ),
              const Spacer(),
              Obx(
                () => AppButton(
                  text: 'Continue',
                  onTap: () => controller.onContinue(),
                  height: 56,
                  disabled: !controller.isPassChangeValid.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
