import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/screens/tab/account/my_detail/my_detail_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart';

class MyDetailScreen extends BaseScreen<MyDetailScreenController> {
  const MyDetailScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(
      title: context.tr('account.myDetails'),
      tabType: TabType.mentors,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container();
  }
}
