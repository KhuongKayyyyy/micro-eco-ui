import 'package:ecommerce_app/screens/tab/account/account_screen.dart';
import 'package:ecommerce_app/screens/tab/account/my_detail/my_detail_screen.dart';
import 'package:ecommerce_app/screens/tab/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/tab/favorite/favorite_screen.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen.dart';
import 'package:ecommerce_app/screens/tab/search/search_screen.dart';
import 'package:ecommerce_app/screens/notifications/notification_screen.dart';
import 'package:ecommerce_app/screens/notifications/notification_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/account/my_detail/my_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/constants/app_routes.dart';

enum TabType { home, hashtags, debate, badges, mentors }

class TabScreenController extends GetxController {
  /// 🔥 Root pages (ONE per tab)
  final List<Widget> pages = const [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  /// 🔥 Cached navigators (IMPORTANT)
  late final List<Widget> tabNavigators;
  late final List<int> tabNavigatorIds;

  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // Use instance-unique IDs to prevent GlobalKey collisions
    // when TabScreenController is recreated.
    final instanceId = DateTime.now().microsecondsSinceEpoch;
    tabNavigatorIds = List.generate(
      pages.length,
      (index) => (instanceId * 10) + index,
    );

    /// ✅ CREATE NAVIGATORS ONLY ONCE (fix duplicate key)
    tabNavigators = List.generate(pages.length, (index) {
      return Navigator(
        key: Get.nestedKey(tabNavigatorIds[index]),
        initialRoute: Navigator.defaultRouteName,
        onGenerateRoute: (settings) {
          final name = settings.name;

          // Route inside the current tab navigator (BottomNavigationBar stays visible).
          if (name == AppRoutes.notification) {
            if (!Get.isRegistered<NotificationScreenController>()) {
              Get.put(NotificationScreenController());
            }
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const NotificationScreen(),
            );
          }

          if (name == AppRoutes.myDetail) {
            if (!Get.isRegistered<MyDetailScreenController>()) {
              Get.put(MyDetailScreenController());
            }
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const MyDetailScreen(),
            );
          }

          // Initial/default route for each tab.
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => pages[index],
          );
        },
      );
    });
  }

  void updatePage(int page) {
    currentIndex.value = page;
  }

  void moveToTabByType(TabType type) {
    updatePage(type.index);
  }

  int navigatorIdForTab(TabType type) => tabNavigatorIds[type.index];
}
