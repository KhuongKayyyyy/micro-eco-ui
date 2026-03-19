import 'package:ecommerce_app/data/serivce/notification_service.dart';
import 'package:ecommerce_app/model/notification_model.dart';
import 'package:get/get.dart';

class NotificationScreenController extends GetxController {
  final List<Notification> notifications =
      NotificationService.getNotifications();
  @override
  void onInit() {
    super.onInit();
    notifications.sort((a, b) => b.notiTime.compareTo(a.notiTime));
  }
}
