import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/components/order/address_component.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/screens/tab/account/address_book/address_book_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddressBookScreen extends BaseScreen<AddressBookScreenController> {
  const AddressBookScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(
      title: context.tr('addressBook.title'),
      isTitleCenter: true,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    const horizontalPadding = 16.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: context.tr('addressBook.savedAddresses'),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  itemCount: 4,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, __) => const _AddressSkeletonCard(),
                );
              }

              if (controller.addresses.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AppText(
                      text: context.tr('addressBook.noAddresses'),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.only(top: 12, bottom: 16),
                itemCount: controller.addresses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final address = controller.addresses[index];
                  final selected =
                      controller.selectedAddressId.value == address.id;
                  return AddressComponent(
                    address: address,
                    selected: selected,
                    onSelect: () => controller.selectAddress(address.id),
                    onEdit: () => controller.onEditAddress(address),
                  );
                },
              );
            }),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppButton(
                text: context.tr('addressBook.addAddress'),
                onTap: () => Get.toNamed(AppRoutes.addAddress),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressSkeletonCard extends StatelessWidget {
  const _AddressSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.gray200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 18,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(height: 16, width: 40, color: Colors.white),
                          const SizedBox(height: 4),
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
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
