import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseScreen<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: GlobalAppBar(title: context.tr("home.title")),
      ),
      body: Text('Home'),
    );
  }
}
