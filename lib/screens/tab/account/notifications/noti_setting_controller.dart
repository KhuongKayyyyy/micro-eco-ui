import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class NotiSettingData {
  final String title;
  final RxBool isSelected;

  NotiSettingData({required this.title, required bool isSelected})
    : isSelected = isSelected.obs;
}

class NotiSettingController extends GetxController {
  final RxList<NotiSettingData> notiSettings = <NotiSettingData>[
    NotiSettingData(
      title: tr('notificationSetting.generalNotifications'),
      isSelected: false,
    ),
    NotiSettingData(
      title: tr('notificationSetting.specialOffer'),
      isSelected: false,
    ),
    NotiSettingData(
      title: tr('notificationSetting.promoDiscounts'),
      isSelected: false,
    ),
    NotiSettingData(
      title: tr('notificationSetting.payments'),
      isSelected: false,
    ),
    NotiSettingData(
      title: tr('notificationSetting.cashBack'),
      isSelected: false,
    ),
    NotiSettingData(
      title: tr('notificationSetting.appUpdates'),
      isSelected: false,
    ),
    NotiSettingData(
      title: tr('notificationSetting.newServiceAvailable'),
      isSelected: false,
    ),
    NotiSettingData(
      title: tr('notificationSetting.newTipsAvailable'),
      isSelected: false,
    ),
  ].obs;

  void setSelected(int index, bool value) {
    notiSettings[index].isSelected.value = value;
  }
}
