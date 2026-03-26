import 'package:ecommerce_app/model/order/order_item.dart';
import 'package:flutter/material.dart';

class OrderItemComponent extends StatelessWidget {
  final OrderItem orderItem;

  const OrderItemComponent({super.key, required this.orderItem});

  String _formatPrice(double value) {
    return '\$${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final currentPrice = orderItem.price;
    final defaultPrice = currentPrice * 1.2;
    const double imageSize = 84;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              orderItem.productImage,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: const Color(0xFFF3F4F6),
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: imageSize,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'x${orderItem.quantity}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatPrice(defaultPrice),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9CA3AF),
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatPrice(currentPrice),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
