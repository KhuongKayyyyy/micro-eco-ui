import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/account/payment_card_component.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/tab/account/payment_method/payment_method_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaymentMethodScreen extends BaseScreen<PaymentMethodScreenController> {
  const PaymentMethodScreen({super.key});

  @override
  bool get setBottomSafeArea => false;

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: AppButton(
          text: context.tr('paymentMethod.apply'),
          onTap: controller.onApply,
          color: AppColors.primary,
          textColor: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(
      title: context.tr('account.paymentMethods'),
      isTitleCenter: true,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    const horizontalPadding = 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: context.tr('paymentMethod.savedCards'),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView(
                  padding: const EdgeInsets.only(top: 12, bottom: 24),
                  children: [
                    _PaymentCardSkeleton(),
                    SizedBox(height: 12),
                    _PaymentCardSkeleton(),
                    SizedBox(height: 12),
                    _PaymentCardSkeleton(),
                    SizedBox(height: 12),
                    _AddNewCardButtonSlot(),
                  ],
                );
              }

              if (controller.cards.isEmpty) {
                return ListView(
                  padding: const EdgeInsets.only(top: 12, bottom: 24),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 32,
                      ),
                      child: AppText(
                        text: context.tr('paymentMethod.noCards'),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _AddNewCardButtonSlot(),
                  ],
                );
              }

              return ListView(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                children: [
                  for (var i = 0; i < controller.cards.length; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    PaymentCardComponent(
                      brand: PaymentCardBrand.fromCardNumber(
                        controller.cards[i].number,
                      ),
                      lastFourDigits: controller.cards[i].lastFourDigits,
                      isDefault: controller.isDefaultCard(controller.cards[i]),
                      isSelected:
                          controller.selectedCardId.value ==
                          controller.cards[i].id,
                      onTap: () =>
                          controller.selectCard(controller.cards[i].id),
                    ),
                  ],
                  const SizedBox(height: 12),
                  _AddNewCardButtonSlot(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Reads label and wires onPressed from [PaymentMethodScreen] context.
class _AddNewCardButtonSlot extends StatelessWidget {
  _AddNewCardButtonSlot();
  final PaymentMethodScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return _AddNewCardButton(
      label: context.tr('paymentMethod.addCard'),
      onPressed: () {
        controller.goToAddNewCard();
      },
    );
  }
}

/// Outlined full-width button: + icon and label, white fill, light gray border.
class _AddNewCardButton extends StatelessWidget {
  const _AddNewCardButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.add, size: 22, color: AppColors.gray900),
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.gray900,
        backgroundColor: AppColors.white,
        side: BorderSide(color: AppColors.gray200, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}

class _PaymentCardSkeleton extends StatelessWidget {
  const _PaymentCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.gray200),
        ),
        child: Row(
          children: [
            Container(width: 56, height: 22, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 18,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
