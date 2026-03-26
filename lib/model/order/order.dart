import 'package:ecommerce_app/model/order/order_item.dart';

class Order {
  final String id;
  final DateTime createdAt;
  final List<OrderItem> items;
  final String shopName;
  final String status;

  Order({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.shopName,
    required this.status,
  });

  double get totalAmount => items.fold(0, (sum, item) => sum + item.total);

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      shopName: json['shopName'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'status': status,
      'shopName': shopName,
    };
  }
}
