import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  var isEmailValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkEmailValidation();
    emailController.addListener(_checkEmailValidation);
  }

  void sendCode() {
    EasyLoading.showSuccess(tr('forgetPassword.sendCodeSuccessful'));
    Get.toNamed(
      AppRoutes.otp,
      arguments: {'email': emailController.text.trim()},
    );
  }

  void _checkEmailValidation() {
    isEmailValid.value = emailController.text.trim().isNotEmpty;
  }
}
