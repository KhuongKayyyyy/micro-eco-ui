import 'package:ecommerce_app/common/theme/theme_service.dart';
import 'package:ecommerce_app/data/dio/dio_service.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeService().init(), fenix: true);
    Get.lazyPut(() => DioService(), fenix: true);
  }
}
