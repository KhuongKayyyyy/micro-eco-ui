import 'package:ecommerce_app/common/enum/order_status_enum.dart';
import 'package:ecommerce_app/model/order/order.dart';
import 'package:ecommerce_app/model/order/order_item.dart';

class OrderService {
  static final List<String> _allStatuses = [
    OrderStatusEnum.pending,
    OrderStatusEnum.processing,
    OrderStatusEnum.shipping,
    OrderStatusEnum.delivered,
    OrderStatusEnum.returned,
    OrderStatusEnum.cancelled,
  ];

  static final List<String> _allShopNames = [
    'Shop 1',
    'Shop 2',
    'Shop 3',
    'Shop 4',
    'Shop 5',
  ];

  /// 101 demo orders with varied statuses and 1-4 items.
  static final List<Order> demoOrders = List.generate(101, (i) {
    final idx = i + 1;

    // Guarantee all statuses appear, then rotate.
    final status = _allStatuses[i % _allStatuses.length];

    final shopName = _allShopNames[i % _allShopNames.length];
    final createdAt = DateTime.now().subtract(Duration(days: i % 120));

    // Varied item count: 1..4
    final itemCount = (i % 4) + 1;

    // Pick different items across orders (deterministic, no randomness).
    final base = (i * 3) % OrderItem.demoItems.length;
    final items = List.generate(itemCount, (j) {
      final item = OrderItem.demoItems[(base + j) % OrderItem.demoItems.length];

      // Vary quantity 1..3
      final qty = ((i + j) % 3) + 1;

      return OrderItem(
        productId: item.productId,
        productName: item.productName,
        productImage: item.productImage,
        productDescription: item.productDescription,
        quantity: qty,
        price: item.price,
      );
    });

    return Order(
      id: 'ORD-${idx.toString().padLeft(4, '0')}',
      createdAt: createdAt,
      items: items,
      status: status,
      shopName: shopName,
    );
  });

  static List<Order> _filterByType(String? type) {
    if (type == null || type.isEmpty || type == 'all') {
      return demoOrders;
    }
    return demoOrders.where((o) => o.status == type).toList();
  }

  static Future<List<Order>> getOrders({
    String? type,
    int page = 1,
    int limit = 101,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final filtered = _filterByType(type);
    final safePage = page < 1 ? 1 : page;
    final safeLimit = limit < 1 ? 0 : limit;
    if (safeLimit == 0) return [];
    return filtered.skip((safePage - 1) * safeLimit).take(safeLimit).toList();
  }
}
