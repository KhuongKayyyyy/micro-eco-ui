import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/product/product_detail/components/product_detail_header.dart';
import 'package:ecommerce_app/screens/product/product_detail/components/product_rating_section.dart';
import 'package:ecommerce_app/screens/product/product_detail/components/product_technical_info_table.dart';
import 'package:ecommerce_app/screens/product/product_detail/components/product_variant_section.dart';
import 'package:ecommerce_app/screens/product/product_detail/product_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends BaseScreen<ProductDetailScreenController> {
  const ProductDetailScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final error = controller.errorMessage.value;
      if (error != null) {
        return Center(
          child: AppText(
            text: error,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.gray700,
          ),
        );
      }

      final detail = controller.detail.value;
      if (detail == null) {
        return Center(
          child: AppText(
            text: 'Không có dữ liệu sản phẩm',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.gray700,
          ),
        );
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductDetailHeader(
              detail: detail,
              selectedColorImage: controller.selectedColorImage.value,
            ),
            const SizedBox(height: 14),
            ProductVariantSection(
              storageOptions: controller.storageOptions,
              selectedStorageIndex: controller.selectedStorageIndex.value,
              onStorageTap: (index) {
                controller.onSelectStorage(index);
              },
              colorOptions: controller.colorOptions,
              selectedColorIndex: controller.selectedColorIndex.value,
              onColorTap: controller.onSelectColor,
            ),
            const SizedBox(height: 14),
            ProductTechnicalInfoTable(attributes: detail.attributes),
            const SizedBox(height: 14),
            const ProductRatingSection(),
          ],
        ),
      );
    });
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(title: context.tr('productDetail.title'));
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return Obx(() {
      final detail = controller.detail.value;
      if (detail == null) return const SizedBox.shrink();
      return SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.gray200)),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    text: 'Giá',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                  ),
                  const Spacer(),
                  AppText(
                    text: _formatPrice(controller.displayPrice),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _IconActionButton(
                    icon: Icons.call_outlined,
                    borderColor: Colors.transparent,
                    iconColor: AppColors.primary,
                    onTap: () {},
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _OutlineActionButton(
                      text: 'Trả góp 0%',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _FilledActionButton(text: 'Mua ngay', onTap: () {}),
                  ),
                  const SizedBox(width: 6),
                  _IconActionButton(
                    icon: Icons.shopping_cart_outlined,
                    borderColor: AppColors.primary,
                    iconColor: AppColors.primary,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  String _formatPrice(double price) {
    final fixed = price.toStringAsFixed(0);
    final withSeparators = fixed.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );
    return '$withSeparatorsđ';
  }
}

class _OutlineActionButton extends StatelessWidget {
  const _OutlineActionButton({required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.statusInfo, width: 1.3),
        ),
        child: AppText(
          text: text,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.statusInfo,
        ),
      ),
    );
  }
}

class _FilledActionButton extends StatelessWidget {
  const _FilledActionButton({required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: AppText(
          text: text,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  const _IconActionButton({
    required this.icon,
    required this.borderColor,
    required this.iconColor,
    this.onTap,
  });

  final IconData icon;
  final Color borderColor;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.3),
        ),
        child: Icon(icon, color: iconColor, size: 21),
      ),
    );
  }
}
