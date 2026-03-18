import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreenController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var isNewPasswordValid = false.obs;
  var isConfirmPasswordValid = false.obs;
  var isPasswordMatch = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
