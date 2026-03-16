// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart'
    hide StringTranslateExtension;
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/image_path.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart' hide TabController;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart' hide Trans;

class TabScreen extends BaseScreen<TabScreenController> {
  const TabScreen({super.key});

  ///
  /// Init
  ///
  @override
  void onInit(BuildContext context) {
    super.onInit(context);
    Get.put(TabScreenController());
  }

  ///
  /// Dispose
  ///
  @override
  void onDispose(BuildContext context) {
    Get.delete<TabScreenController>();
    super.onDispose(context);
  }

  ///
  /// 화면 본문
  ///
  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => PageView(
        controller: viewModel.pageController,
        physics: const NeverScrollableScrollPhysics(), // 스와이프 비활성화
        onPageChanged: (index) {
          viewModel.currentIndex.value = index;
        },
        children: viewModel.pages.mapIndexed((index, page) {
          return page
              .animate(target: viewModel.currentIndex.value == index ? 1 : 0)
              .fade(duration: 200.ms);
        }).toList(),
      ),
    );
  }

  ///
  /// 하단 네비게이션 바
  ///
  @override
  Widget buildBottomNavigationBar(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: viewModel.currentIndex.value,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor:
            Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.gray900,
        unselectedItemColor:
            // ignore: deprecated_member_use
            Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ??
            AppColors.gray500,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        onTap: (index) {
          viewModel.currentIndex.value = index;
          viewModel.pageController.jumpToPage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagePaths.tabHomeOFF,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              ImagePaths.tabHomeON,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            label: context.tr('menu.home'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagePaths.tabHashtagOFF,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              ImagePaths.tabHashtagON,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            label: context.tr('menu.hashtags'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagePaths.tabDebateOFF,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              ImagePaths.tabDebateON,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            label: context.tr('menu.debate'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagePaths.tabBadgeOFF,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              ImagePaths.tabBadgeON,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            label: context.tr('menu.badges'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImagePaths.tabMentorOFF,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              ImagePaths.tabMentorON,
              width: 24,
              height: 24,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            label: context.tr('menu.mentors'),
          ),
        ],
      ),
    );
  }
}
