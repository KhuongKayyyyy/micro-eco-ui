import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreenController extends GetxController {
  RxBool isCodeFille = false.obs;
  late final String email;

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'] as String;
    verifyOtp();
    for (final controller in otpControllers) {
      controller.addListener(() {
        verifyOtp();
      });
    }
  }

  void onOtpChanged(int index, String value) {
    if (value.length == 1 && index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  String get otpCode =>
      otpControllers.map((controller) => controller.text).join();

  @override
  void onClose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void verifyOtp() {
    if (otpCode.length == 4) {
      isCodeFille.value = true;
    } else {
      isCodeFille.value = false;
    }
  }
}
