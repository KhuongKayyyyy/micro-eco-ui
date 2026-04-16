import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/global_search_bar.dart';
import 'package:ecommerce_app/components/product/search_root_category_item.dart';
import 'package:ecommerce_app/common/utils/app_navigator_utils.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/screens/tab/search/search_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends BaseScreen<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: GlobalSearchBar(hintText: context.tr("searchScreen.hintText")),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 92,
                  child: Obx(() {
                    if (controller.isLoadingRootCategories.value) {
                      return ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Skeletonizer(
                            enabled: true,
                            child: Container(
                              height: 94,
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.gray100,
                                border: Border(
                                  right: BorderSide(
                                    color: AppColors.gray200,
                                    width: 1,
                                  ),
                                  bottom: BorderSide(
                                    color: AppColors.gray200,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    final list = controller.rootCategories;
                    final selectedId = controller.selectedRootCategoryId.value;
                    if (list.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: AppText(
                            text: context.tr('searchScreen.noCategories'),
                            fontSize: 13,
                            color: AppColors.gray500,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final category = list[index];
                        final isSelected = selectedId == category.id;
                        return SizedBox(
                          key: ValueKey('root-${category.id}-$isSelected'),
                          height: 94,
                          child: SearchRootCategoryItem(
                            category: category,
                            isSelected: isSelected,
                            onTap: () =>
                                controller.selectRootCategory(category.id),
                          ),
                        );
                      },
                    );
                  }),
                ),
                Expanded(
                  child: Obx(() {
                    final selected = controller.rootCategories.firstWhereOrNull(
                      (e) => e.id == controller.selectedRootCategoryId.value,
                    );

                    return Container(
                      color: const Color(0xFFF5F5F5),
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (selected != null)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.gray200),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: selected.name,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gray900,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => AppNavigatorUtils.goToScreen(
                                      context,
                                      AppRoutes.productList,
                                      arguments: {
                                        'categoryId': selected.id,
                                        'categoryName': selected.name,
                                      },
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      child: Row(
                                        children: [
                                          AppText(
                                            text: context.tr(
                                              'searchScreen.viewAll',
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF4F7BB9),
                                          ),
                                          const SizedBox(width: 2),
                                          const Icon(
                                            Icons.chevron_right_rounded,
                                            size: 18,
                                            color: Color(0xFF4F7BB9),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: SingleChildScrollView(
                              child: _SectionCard(
                                title: context.tr(
                                  'searchScreen.brandSectionTitle',
                                ),
                                child: _BrandGridSection(
                                  isLoading: controller.isLoadingBrands.value,
                                  noDataText: context.tr(
                                    'searchScreen.noBrands',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _BrandGridSection extends GetView<SearchScreenController> {
  const _BrandGridSection({required this.isLoading, required this.noDataText});

  final bool isLoading;
  final String noDataText;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          8,
          (index) => const Skeletonizer(
            enabled: true,
            child: _BrandChip(label: 'Brand'),
          ),
        ),
      );
    }

    final brands = controller.brands;
    if (brands.isEmpty) {
      return AppText(text: noDataText, fontSize: 13, color: AppColors.gray500);
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final b in brands)
          _BrandChip(
            label: b.name,
            imageUrl: b.image,
            onTap: () => AppNavigatorUtils.goToScreen(
              context,
              AppRoutes.productList,
              arguments: {
                'categoryId': controller.selectedRootCategoryId.value,
                'categoryName': controller.rootCategories
                    .firstWhereOrNull(
                      (e) => e.id == controller.selectedRootCategoryId.value,
                    )
                    ?.name,
                'brandId': b.id,
              },
            ),
          ),
      ],
    );
  }
}

class _BrandChip extends StatelessWidget {
  const _BrandChip({required this.label, this.imageUrl, this.onTap});

  final String label;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 86, maxWidth: 108),
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.gray200),
          color: AppColors.white,
        ),
        alignment: Alignment.center,
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => _BrandLabel(label: label),
                loadingBuilder: (context, child, progress) =>
                    progress == null ? child : _BrandLabel(label: label),
              )
            : _BrandLabel(label: label),
      ),
    );
  }
}

class _BrandLabel extends StatelessWidget {
  const _BrandLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: label,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.gray900,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
