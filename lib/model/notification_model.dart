import 'package:ecommerce_app/common/enum/notification_type.dart';

class Notification {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime notiTime;
  final String createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.notiTime,
    required this.createdAt,
  });
}

// Mock data for each notification type
final DateTime today = DateTime.now();
final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
final DateTime futureDate = DateTime(2026, 3, 8);

final Notification orderNotification = Notification(
  id: '1',
  title: 'Order Confirmed',
  message: 'Your order has been confirmed.',
  type: NotificationType.order,
  notiTime: today,
  createdAt: today.toIso8601String(),
);

final Notification promotionNotification = Notification(
  id: '2',
  title: 'Special Promotion!',
  message: 'Enjoy 20% off for a limited time.',
  type: NotificationType.promotion,
  notiTime: yesterday,
  createdAt: yesterday.toIso8601String(),
);

final Notification billingNotification = Notification(
  id: '3',
  title: 'Billing Update',
  message: 'Your bill has been generated.',
  type: NotificationType.billing,
  notiTime: futureDate,
  createdAt: futureDate.toIso8601String(),
);

final Notification deliveryNotification = Notification(
  id: '4',
  title: 'Delivery Scheduled',
  message: 'Your order will be delivered tomorrow.',
  type: NotificationType.delivery,
  notiTime: today,
  createdAt: today.toIso8601String(),
);
