import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/screens/tab/cart/cart_screen_controller.dart';
import 'package:flutter/material.dart';

class CartScreen extends BaseScreen<CartScreenController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('cart screen'));
  }

  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    throw UnimplementedError();
  }
}
