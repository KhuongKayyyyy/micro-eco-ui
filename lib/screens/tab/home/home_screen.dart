import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/data/serivce/address_service.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends BaseScreen<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: GlobalAppBar(
          title: context.tr("home.title"),
          tabType: TabType.home,
        ),
      ),
      body: Column(
        children: [
          Text('Home'),
          AppButton(
            text: 'Get All Provinces',
            onTap: () {
              Get.toNamed(AppRoutes.provinceSelect);
            },
          ),
        ],
      ),
    );
  }
}
