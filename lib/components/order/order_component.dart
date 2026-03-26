import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/model/order/order.dart';
import 'package:ecommerce_app/common/enum/order_status_enum.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/order/order_item_component.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderComponent extends StatefulWidget {
  final Order order;
  final String? shopName;

  const OrderComponent({super.key, required this.order, this.shopName});

  @override
  State<OrderComponent> createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  String get _shopName => widget.shopName?.trim().isNotEmpty == true
      ? widget.shopName!.trim()
      : 'Ecommerce Shop';

  String _statusLabel(String status) {
    if (status.isEmpty) return '';
    return status[0].toUpperCase() + status.substring(1);
  }

  Color _statusColor(String status) {
    switch (status) {
      case OrderStatusEnum.processing:
        return AppColors.statusInfo;
      case OrderStatusEnum.shipping:
        return AppColors.statusWarn;
      case OrderStatusEnum.delivered:
        return AppColors.statusSuccess;
      case OrderStatusEnum.returned:
        return AppColors.gray700;
      case OrderStatusEnum.cancelled:
        return AppColors.statusError;
      case OrderStatusEnum.pending:
      default:
        return AppColors.gray700;
    }
  }

  String _shippingEtaText() {
    // Simple placeholder ETA derived from createdAt for now.
    final start = widget.order.createdAt.add(const Duration(days: 3));
    final end = widget.order.createdAt.add(const Duration(days: 5));
    String fmt(DateTime d) =>
        '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
    return 'The order will be in in around ${fmt(start)} , ${fmt(end)}';
  }

  Widget _actionButton({
    required String text,
    required VoidCallback onTap,
    bool disabled = false,
    bool outlined = false,
    double width = 140,
  }) {
    return AppButton(
      text: text,
      onTap: onTap,
      disabled: disabled,
      height: 36,
      width: width,
      borderRadius: 10,
      color: outlined ? AppColors.white : AppColors.primary,
      textColor: outlined ? AppColors.primary : AppColors.white,
      border: outlined ? Border.all(color: AppColors.gray300) : null,
      fontSize: 13,
      fontWeight: FontWeight.w700,
    );
  }

  List<Widget> _buildActions() {
    final status = widget.order.status;

    if (status == OrderStatusEnum.shipping) {
      return [
        _actionButton(
          text: context.tr('myOrders.received'),
          disabled: true,
          onTap: () {},
          outlined: true,
        ),
        const SizedBox(width: 10),
        _actionButton(text: context.tr('myOrders.trackOrder'), onTap: () {}),
      ];
    }

    if (status == OrderStatusEnum.processing) {
      return [
        _actionButton(
          text: context.tr('myOrders.contactShop'),
          onTap: () {},
          outlined: true,
        ),
      ];
    }

    // "shipped" in your message maps best to delivered in our enum.
    if (status == OrderStatusEnum.delivered) {
      return [
        _actionButton(
          text: context.tr('myOrders.returnRefund'),
          onTap: () {},
          outlined: true,
        ),
        const SizedBox(width: 10),
        _actionButton(text: context.tr('myOrders.buyAgain'), onTap: () {}),
      ];
    }

    if (status == OrderStatusEnum.returned) {
      return [
        _actionButton(
          text: context.tr('myOrders.viewDetails'),
          onTap: () {},
          outlined: true,
        ),
      ];
    }

    if (status == OrderStatusEnum.cancelled) {
      return [
        _actionButton(
          text: context.tr('myOrders.viewCancelDetail'),
          onTap: () {},
          outlined: true,
        ),
        const SizedBox(width: 10),
        _actionButton(text: context.tr('myOrders.buyAgain'), onTap: () {}),
      ];
    }

    return const [];
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.order.items;
    final hasMore = items.length > 1;
    final statusColor = _statusColor(widget.order.status);

    return Container(
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
              Expanded(
                child: AppText(
                  text: _shopName,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.gray900,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.25),
                  ),
                ),
                child: AppText(
                  text: _statusLabel(widget.order.status),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (items.isNotEmpty) OrderItemComponent(orderItem: items.first),
          if (hasMore) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  foregroundColor: AppColors.primary,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: _expanded
                          ? context.tr('myOrders.hide')
                          : context.tr('myOrders.viewMore'),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: !_expanded
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        for (final item in items.skip(1)) ...[
                          const SizedBox(height: 10),
                          OrderItemComponent(orderItem: item),
                        ],
                      ],
                    ),
            ),
          ],
          if (widget.order.status == OrderStatusEnum.shipping) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 18,
                    color: AppColors.gray800,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppText(
                      text: _shippingEtaText(),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.gray800,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Builder(
            builder: (context) {
              final actions = _buildActions();
              if (actions.isEmpty) return const SizedBox.shrink();
              return Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
