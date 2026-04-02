import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/components/general/global_search_bar.dart';
import 'package:ecommerce_app/components/product/product_category_item.dart';
import 'package:ecommerce_app/components/product/product_item.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';
import 'package:ecommerce_app/screens/tab/home/home_screen_controller.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends BaseScreen<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: GlobalAppBar(
        title: context.tr("home.title"),
        tabType: TabType.home,
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        buildHomeSearchBar(context),
        buildProductCategories(context),
        Expanded(child: buildProductGrid(context)),
      ],
    );
  }

  Widget buildHomeSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: GlobalSearchBar(hintText: context.tr('home.searchHint')),
          ),
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.filter_list_rounded, color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget buildProductCategories(BuildContext context) {
    final allCategory = ProductCategory(id: 'all', name: 'All');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 40,
        child: Obx(() {
          if (controller.isLoadingCategories.value) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, __) => const _CategoryChipSkeleton(width: 90),
            );
          }

          final listLen = controller.categories.length + 1; // + "All"

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: listLen,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = index == 0
                  ? allCategory
                  : controller.categories[index - 1];
              final isSelected =
                  controller.selectedCategoryIndex.value == index;

              return ProductCategoryItem(
                category: category,
                isSelected: isSelected,
                onTap: () => controller.onProductCategorySelected(index),
              );
            },
          );
        }),
      ),
    );
  }

  Widget buildProductGrid(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingProducts.value) {
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Skeletonizer(
              enabled: true,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(height: 18, width: 90, color: AppColors.gray100),
                    const SizedBox(height: 8),
                    Container(height: 14, width: 70, color: AppColors.gray100),
                  ],
                ),
              ),
            );
          },
        );
      }

      final list = controller.products;
      if (list.isEmpty) {
        return const SizedBox.shrink();
      }

      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: list[index],
            isFavorite: false,
            onFavoriteTap: () {},
            onTap: () {},
          );
        },
      );
    });
  }
}

class _CategoryChipSkeleton extends StatelessWidget {
  const _CategoryChipSkeleton({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
