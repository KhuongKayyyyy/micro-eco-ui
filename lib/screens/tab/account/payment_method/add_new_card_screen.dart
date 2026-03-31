import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/dialog/success_dialog.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/app_textfield.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/tab/account/payment_method/add_new_card_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddNewCardScreen extends BaseScreen<AddNewCardScreenController> {
  const AddNewCardScreen({super.key});

  static const double _hPad = 16;
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: AppText(
        text: context.tr('paymentMethod.addCardTitle'),
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColors.gray900,
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(_hPad, 16, _hPad, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  labelText: context.tr('paymentMethod.cardNumberLabel'),
                  textController: controller.cardNumberController,
                  hintText: context.tr('paymentMethod.cardNumberHint'),
                  keyBoardType: TextInputType.number,
                  radius: 12,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            labelText: context.tr('paymentMethod.expiryLabel'),
                            textController: controller.expiryDateController,
                            hintText: context.tr('paymentMethod.expiryHint'),
                            keyBoardType: TextInputType.number,
                            maxLength: 4,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            radius: 12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            labelText: context.tr('paymentMethod.cvvLabel'),
                            textController: controller.cvvController,
                            hintText: context.tr('paymentMethod.cvvHint'),
                            keyBoardType: TextInputType.number,
                            obscureText: true,
                            radius: 12,
                            suffixIcon: Icon(
                              Icons.help_outline_rounded,
                              size: 20,
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(_hPad, 0, _hPad, 12),
              child: AppButton(
                text: context.tr('paymentMethod.addCard'),
                color: AppColors.primary,
                textColor: AppColors.white,
                fontWeight: FontWeight.w700,
                disabled: !controller.isFilled.value,
                height: 52,
                borderRadius: 10,
                onTap: controller.isFilled.value
                    ? () {
                        controller.onAddCard();
                      }
                    : () {
                        return;
                      },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
