import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/account/cart/cart_item.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/tab/cart/cart_screen_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends BaseScreen<CartScreenController> {
  const CartScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: AppText(
        text: context.tr('cartScreen.title'),
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.gray900,
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined, color: Colors.black),
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(() {
      final loading = controller.isLoading.value;
      final items = controller.carts;
      final hasItems = items.isNotEmpty;
      final expanded = controller.isCostExpanded.value;
      final subtotal = loading ? 5870.0 : controller.subTotal;
      final vat = loading ? 0.0 : controller.vat;
      final shipping = loading ? 80.0 : controller.shippingFee;
      final total = loading ? 5950.0 : controller.total;

      return Column(
        children: [
          Expanded(
            child: Skeletonizer(
              enabled: loading,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                children: [
                  if (loading) ...[
                    const _CartSkeletonItem(),
                    const SizedBox(height: 12),
                    const _CartSkeletonItem(),
                    const SizedBox(height: 12),
                    const _CartSkeletonItem(),
                  ] else if (!hasItems) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: AppText(
                        text: context.tr('cartScreen.empty'),
                        textAlign: TextAlign.center,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray500,
                      ),
                    ),
                  ] else ...[
                    for (var i = 0; i < items.length; i++) ...[
                      if (i > 0) const SizedBox(height: 12),
                      CartItemComponent(
                        cart: items[i],
                        onDelete: () => controller.removeItem(items[i].id),
                        onIncreaseQty: () => controller.increaseQty(items[i].id),
                        onDecreaseQty: () => controller.decreaseQty(items[i].id),
                        onSimilarProduct: () {},
                      ),
                    ],
                  ],
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _BottomCostSection(
                    subtotal: subtotal,
                    vat: vat,
                    shipping: shipping,
                    total: total,
                    expanded: expanded,
                    onToggleExpanded: controller.toggleCostExpanded,
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: context.tr('cartScreen.checkout'),
                    onTap: () {},
                    borderRadius: 14,
                    height: 56,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _BottomCostSection extends StatelessWidget {
  const _BottomCostSection({
    required this.subtotal,
    required this.vat,
    required this.shipping,
    required this.total,
    required this.expanded,
    required this.onToggleExpanded,
  });

  final double subtotal;
  final double vat;
  final double shipping;
  final double total;
  final bool expanded;
  final VoidCallback onToggleExpanded;

  String _money(double value) => '\$ ${NumberFormat('#,##0.00').format(value)}';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  text: context.tr('cartScreen.total'),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray900,
                ),
              ),
              AppText(
                text: _money(total),
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.gray900,
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onToggleExpanded,
                child: Icon(
                  expanded
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: AppColors.gray700,
                  size: 24,
                ),
              ),
            ],
          ),
          if (expanded) ...[
            const SizedBox(height: 10),
            Divider(color: AppColors.gray200, height: 1),
            const SizedBox(height: 10),
            _SummaryRow(
              label: context.tr('cartScreen.subtotal'),
              value: _money(subtotal),
            ),
            const SizedBox(height: 8),
            _SummaryRow(label: context.tr('cartScreen.vat'), value: _money(vat)),
            const SizedBox(height: 8),
            _SummaryRow(
              label: context.tr('cartScreen.shipping'),
              value: _money(shipping),
            ),
          ],
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppText(
            text: label,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.gray500,
          ),
        ),
        AppText(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
      ],
    );
  }
}

class _CartSkeletonItem extends StatelessWidget {
  const _CartSkeletonItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        children: [
          Container(width: 96, height: 96, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 18, width: double.infinity, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 14, width: 90, color: Colors.white),
                const SizedBox(height: 18),
                Container(height: 20, width: 90, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
