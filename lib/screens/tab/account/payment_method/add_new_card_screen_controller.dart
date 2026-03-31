import 'package:easy_localization/easy_localization.dart' as context;
import 'package:ecommerce_app/components/dialog/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewCardScreenController extends GetxController {
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final RxBool isFilled = false.obs;

  @override
  void onInit() {
    super.onInit();
    cardNumberController.addListener(_checkValidation);
    expiryDateController.addListener(_checkValidation);
    cvvController.addListener(_checkValidation);
  }

  void _checkValidation() {
    isFilled.value =
        cardNumberController.text.isNotEmpty &&
        expiryDateController.text.isNotEmpty &&
        cvvController.text.isNotEmpty;
  }

  void onAddCard() {
    Get.dialog(
      SucessDialog(
        title: context.tr('paymentMethod.cardAdded'),
        buttonText: context.tr('paymentMethod.addCard'),
        subtitle: context.tr('paymentMethod.cardAddedSubtitle'),
        onButtonTap: () {
          Get.back();
        },
      ),
      barrierDismissible: false,
    );
  }
}
