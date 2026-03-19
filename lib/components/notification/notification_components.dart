import 'package:ecommerce_app/common/enum/notification_type.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/model/notification_model.dart';
import 'package:flutter/material.dart' hide Notification;

class NotificationComponents {
  static Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AppText(
        text: title,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  static Widget notificationItem(Notification notification) {
    final iconData = _iconForType(notification.type);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, size: 20, color: const Color(0xFF444444)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: notification.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                const SizedBox(height: 6),
                AppText(
                  text: notification.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13,
                  height: 1.25,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8B8B8B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static IconData _iconForType(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.promotion:
        return Icons.local_offer_outlined;
      case NotificationType.order:
        return Icons.shopping_bag_outlined;
      case NotificationType.billing:
        return Icons.receipt_long_outlined;
      case NotificationType.delivery:
        return Icons.local_shipping_outlined;
    }
  }
}
