import 'package:ecommerce_app/screens/tab/account/account_screen.dart';
import 'package:ecommerce_app/screens/tab/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/tab/favorite/favorite_screen.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen.dart';
import 'package:ecommerce_app/screens/tab/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum TabType { home, hashtags, debate, badges, mentors }

/// 탭 화면 컨트롤러
class TabScreenController extends GetxController {
  final List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  RxInt currentIndex = 0.obs; // 현재 선택된 탭 인덱스 추가
  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  void upatePage(int page) {
    pageController.jumpToPage(page);
  }

  ///
  /// 탭 이동
  ///
  void moveToTabByType(TabType type) {
    switch (type) {
      case TabType.home:
        pageController.jumpToPage(0);
        break;
      case TabType.hashtags:
        pageController.jumpToPage(1);
        break;
      case TabType.debate:
        pageController.jumpToPage(2);
        break;
      case TabType.badges:
        pageController.jumpToPage(3);
        break;
      case TabType.mentors:
        pageController.jumpToPage(4);
        break;
    }
  }
}
