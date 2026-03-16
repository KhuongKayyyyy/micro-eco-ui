import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/screens/tab/favorite/favorite_screen_controller.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends BaseScreen<FavoriteScreenController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('favorite screen'));
  }

  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    throw UnimplementedError();
  }
}
