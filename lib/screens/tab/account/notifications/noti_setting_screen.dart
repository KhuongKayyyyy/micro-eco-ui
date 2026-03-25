import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/components/notification/noti_setting_item.dart';
import 'package:ecommerce_app/screens/tab/account/notifications/noti_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotiSettingScreen extends BaseScreen<NotiSettingController> {
  const NotiSettingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final entry in controller.notiSettings.asMap().entries)
              NotiSettingItem(
                title: entry.value.title,
                isSelected: entry.value.isSelected.value,
                isLastItem: entry.key == controller.notiSettings.length - 1,
                onChanged: (v) => controller.setSelected(entry.key, v),
              ),
          ],
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(title: context.tr('notificationSetting.title'));
  }
}
