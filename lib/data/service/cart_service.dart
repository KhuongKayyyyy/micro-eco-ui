import 'package:ecommerce_app/model/cart/cart_model.dart';

class CartService {
  static Future<List<CartModel>> getCartItems() async {
    // Simulate network delay for fake loading
    await Future.delayed(const Duration(seconds: 2));
    return CartModel.mockData;
  }
}
