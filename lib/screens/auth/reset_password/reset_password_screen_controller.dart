import 'package:ecommerce_app/components/dialog/password_changed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreenController extends GetxController {
  RxBool isPassChangeValid = false.obs;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var isNewPasswordValid = false.obs;
  var isConfirmPasswordValid = false.obs;
  var isPasswordMatch = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkPasswordFilled();
    newPasswordController.addListener(_checkPasswordFilled);
    confirmPasswordController.addListener(_checkPasswordValidation);
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void onContinue() {
    if (isPassChangeValid.value) {
      Get.dialog(const PasswordChangedDialog(), barrierDismissible: false);
    }
  }

  void _checkPasswordFilled() {
    isNewPasswordValid.value = newPasswordController.text.trim().isNotEmpty;
    isConfirmPasswordValid.value = confirmPasswordController.text
        .trim()
        .isNotEmpty;
    if (isNewPasswordValid.value && isConfirmPasswordValid.value) {
      isPassChangeValid.value = true;
    } else {
      isPassChangeValid.value = false;
    }
  }

  void _checkPasswordValidation() {
    isNewPasswordValid.value = newPasswordController.text.trim().isNotEmpty;
    isConfirmPasswordValid.value = confirmPasswordController.text
        .trim()
        .isNotEmpty;
    isPasswordMatch.value =
        newPasswordController.text.trim() ==
        confirmPasswordController.text.trim();
    if (isNewPasswordValid.value &&
        isConfirmPasswordValid.value &&
        isPasswordMatch.value) {
      isPassChangeValid.value = true;
      Get.dialog(const PasswordChangedDialog(), barrierDismissible: false);
    } else {
      isPassChangeValid.value = false;
    }
  }
}
