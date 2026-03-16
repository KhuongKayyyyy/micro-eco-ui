import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseScreen<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('home screen'));
  }

  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    throw UnimplementedError();
  }
}
