import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/components/order/order_component.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/tab/account/my_order_screen/my_order_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyOrderScreen extends BaseScreen<MyOrderScreenController> {
  const MyOrderScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(title: 'My Orders', isTitleCenter: true);
  }

  @override
  Widget buildBody(BuildContext context) {
    const horizontalPadding = 20.0;

    return Column(
      children: [
        const Divider(color: Color(0xFFEDEDED), thickness: 1, height: 1),
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 10),
          child: SizedBox(
            height: 46,
            child: Obx(() => _buildSegmentedControl(context)),
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 12,
                ),
                itemCount: 3,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return const _OrderSkeletonCard();
                },
              );
            }

            if (controller.orders.isEmpty) {
              final selectedType = controller.selectedType.value;
              final matching = controller.orderTypeSegments
                  .where((e) => e['type'] == selectedType)
                  .toList();
              final selectedLabel = matching.isNotEmpty
                  ? matching.first['label']!
                  : 'All';

              return _buildEmptyOrderState(
                label: selectedLabel,
                horizontalPadding: horizontalPadding,
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 12,
              ),
              itemCount: controller.orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = controller.orders[index];
                return OrderComponent(order: order, shopName: order.shopName);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    final segments = controller.orderTypeSegments;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: segments.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final seg = segments[index];
        final label = seg['label']!;
        final type = seg['type']!;
        final selected = controller.selectedType.value == type;

        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => controller.onChangeType(type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected ? Colors.black : const Color(0xFFEDEDED),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyOrderState({
    required String label,
    required double horizontalPadding,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.gray200),
              ),
              child: Center(
                child: Icon(
                  Icons.receipt_long_outlined,
                  size: 36,
                  color: AppColors.gray700,
                ),
              ),
            ),
            const SizedBox(height: 18),
            AppText(
              text: 'No orders for $label yet',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.gray900,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            AppText(
              text: 'When you place an order, it will appear here.',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.gray600,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderSkeletonCard extends StatelessWidget {
  const _OrderSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.gray200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(height: 18, width: 150, color: Colors.white),
                const SizedBox(width: 10),
                Container(height: 24, width: 86, color: Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6),
                      Container(height: 14, width: 120, color: Colors.white),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 12,
                              width: 70,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 16,
                              width: 64,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(height: 36, width: 220, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
