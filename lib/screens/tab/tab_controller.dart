import 'package:ecommerce_app/screens/tab/account/account_screen.dart';
import 'package:ecommerce_app/screens/tab/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/tab/favorite/favorite_screen.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen.dart';
import 'package:ecommerce_app/screens/tab/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/common/routes/app_pages.dart';

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
  late final Map<String, GetPage> _routeMap;

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
          final uri = name == null ? null : Uri.tryParse(name);
          final queryParameters = uri?.queryParameters ?? const <String, String>{};

          // Use GetX route definitions (binding/controllers) already defined in `AppPages`.
          final getPage = _findGetPage(name);
          if (getPage != null) {
            final mergedArguments = _mergeRouteArguments(
              settings.arguments,
              queryParameters,
            );
            final routeSettings = RouteSettings(
              name: uri?.path ?? name,
              arguments: mergedArguments,
            );
            return GetPageRoute(
              settings: routeSettings,
              page: getPage.page,
              binding: getPage.binding,
              bindings: getPage.bindings,
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
    _routeMap = {for (final page in AppPages.pages) page.name: page};
  }

  void updatePage(int page) {
    currentIndex.value = page;
  }

  void moveToTabByType(TabType type) {
    updatePage(type.index);
  }

  int navigatorIdForTab(TabType type) => tabNavigatorIds[type.index];

  GetPage? _findGetPage(String? name) {
    if (name == null) return null;
    final directMatch = _routeMap[name];
    if (directMatch != null) return directMatch;

    final uri = Uri.tryParse(name);
    if (uri == null) return null;
    return _routeMap[uri.path];
  }

  dynamic _mergeRouteArguments(
    dynamic originalArguments,
    Map<String, String> queryParameters,
  ) {
    if (queryParameters.isEmpty) return originalArguments;

    final merged = <String, dynamic>{...queryParameters};
    if (originalArguments is Map) {
      for (final entry in originalArguments.entries) {
        merged[entry.key.toString()] = entry.value;
      }
    }
    return merged;
  }
}
