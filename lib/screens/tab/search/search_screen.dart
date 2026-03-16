import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/screens/tab/search/search_screen_controller.dart';
import 'package:flutter/material.dart';

class SearchScreen extends BaseScreen<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('search screen');
  }

  @override
  Widget buildBody(BuildContext context) {
    throw UnimplementedError();
  }
}
