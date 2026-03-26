import 'package:ecommerce_app/common/enum/order_status_enum.dart';
import 'package:ecommerce_app/data/serivce/order_service.dart';
import 'package:ecommerce_app/model/order/order.dart';
import 'package:get/get.dart';

class MyOrderScreenController extends GetxController {
  final RxString selectedType = 'all'.obs;
  final RxBool isLoading = false.obs;

  final RxList<Order> orders = <Order>[].obs;

  // Demo service has 101 orders; using 101 means "show all" for this UI.
  final int page = 1;
  final int limit = 101;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders({String? type}) async {
    final nextType = (type ?? selectedType.value).trim();

    try {
      isLoading.value = true;
      final result = await OrderService.getOrders(
        type: nextType,
        page: page,
        limit: limit,
      );
      orders.assignAll(result);
      selectedType.value = nextType;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onChangeType(String type) async {
    if (type == selectedType.value) return;
    // Update selected UI immediately, then load data.
    selectedType.value = type;
    await fetchOrders(type: type);
  }

  List<Map<String, String>> get orderTypeSegments => [
        {'label': 'All', 'type': 'all'},
        {'label': 'Pending', 'type': OrderStatusEnum.pending},
        {'label': 'Processing', 'type': OrderStatusEnum.processing},
        {'label': 'Shipping', 'type': OrderStatusEnum.shipping},
        {'label': 'Delivered', 'type': OrderStatusEnum.delivered},
        {'label': 'Returned', 'type': OrderStatusEnum.returned},
        {'label': 'Cancelled', 'type': OrderStatusEnum.cancelled},
      ];
}
