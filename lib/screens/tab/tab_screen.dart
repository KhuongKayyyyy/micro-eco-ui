import 'package:easy_localization/easy_localization.dart'
    hide StringTranslateExtension;
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart' hide TabController;
import 'package:get/get.dart' hide Trans;

class TabScreen extends BaseScreen<TabScreenController> {
  const TabScreen({super.key});

  ///
  /// 화면 본문
  ///
  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => IndexedStack(
        index: viewModel.currentIndex.value,
        children: [for (final navigator in viewModel.tabNavigators) navigator],
      ),
    );
  }

  ///
  /// 하단 네비게이션 바
  ///
  @override
  Widget buildBottomNavigationBar(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
          BottomNavigationBar(
            currentIndex: viewModel.currentIndex.value,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            type: BottomNavigationBarType.fixed,
            enableFeedback: false,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor:
                Theme.of(context).textTheme.bodyLarge?.color ??
                AppColors.gray900,
            unselectedItemColor:
                // ignore: deprecated_member_use
                Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.7) ??
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
              viewModel.updatePage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 0 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.home_outlined),
                ),
                activeIcon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 0 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.home),
                ),
                label: context.tr('menu.home'),
              ),
              BottomNavigationBarItem(
                icon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 1 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.search_outlined),
                ),
                activeIcon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 1 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.search),
                ),
                label: context.tr('menu.search'),
              ),
              BottomNavigationBarItem(
                icon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 2 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.favorite_border_outlined),
                ),
                activeIcon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 2 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.favorite),
                ),
                label: context.tr('menu.favorite'),
              ),
              BottomNavigationBarItem(
                icon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 3 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                activeIcon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 3 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.shopping_cart),
                ),
                label: context.tr('menu.cart'),
              ),
              BottomNavigationBarItem(
                icon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 4 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.person_outline),
                ),
                activeIcon: AnimatedScale(
                  scale: viewModel.currentIndex.value == 4 ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: const Icon(Icons.person),
                ),
                label: context.tr('menu.account'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
