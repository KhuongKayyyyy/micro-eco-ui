import 'package:get/get.dart';
import 'package:ecommerce_app/data/service/cart_service.dart';
import 'package:ecommerce_app/model/cart/cart_model.dart';

class CartScreenController extends GetxController {
  final isLoading = true.obs;
  final carts = <CartModel>[].obs;
  final isCostExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCarts();
  }

  Future<void> fetchCarts() async {
    isLoading.value = true;
    try {
      final result = await CartService.getCartItems();
      carts.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  void removeItem(String id) {
    carts.removeWhere((item) => item.id == id);
  }

  void increaseQty(String id) {
    final i = carts.indexWhere((item) => item.id == id);
    if (i < 0) return;
    final item = carts[i];
    carts[i] = CartModel(
      id: item.id,
      name: item.name,
      image: item.image,
      description: item.description,
      price: item.price,
      quantity: item.quantity + 1,
    );
  }

  void decreaseQty(String id) {
    final i = carts.indexWhere((item) => item.id == id);
    if (i < 0) return;
    final item = carts[i];
    if (item.quantity <= 1) return;
    carts[i] = CartModel(
      id: item.id,
      name: item.name,
      image: item.image,
      description: item.description,
      price: item.price,
      quantity: item.quantity - 1,
    );
  }

  double get subTotal =>
      carts.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get vat => 0.0;

  double get shippingFee => carts.isEmpty ? 0 : 80;

  double get total => subTotal + vat + shippingFee;

  void toggleCostExpanded() {
    isCostExpanded.toggle();
  }
}
