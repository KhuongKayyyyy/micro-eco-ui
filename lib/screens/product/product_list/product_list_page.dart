import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/product/product_item.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/product/product_model.dart';
import 'package:ecommerce_app/screens/product/components/brand_in_category_list.dart';
import 'package:ecommerce_app/screens/product/components/filter_list.dart';
import 'package:ecommerce_app/screens/product/product_list/article_webview_page.dart';
import 'package:ecommerce_app/screens/product/product_list/components/article_list.dart';
import 'package:ecommerce_app/screens/product/product_list/components/criteria_list.dart';
import 'package:ecommerce_app/screens/product/product_list/components/faq_section.dart';
import 'package:ecommerce_app/screens/product/product_list/components/filter_pop_up.dart';
import 'package:ecommerce_app/screens/product/product_list/components/price_filter_pop_up.dart';
import 'package:ecommerce_app/screens/product/product_list/components/product_banner.dart';
import 'package:ecommerce_app/screens/product/product_list/product_list_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductListPage extends BaseScreen<ProductListPageController> {
  const ProductListPage({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: AppText(
        text: 'Product list',
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: true,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductBanner(
              imageUrls: [
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:595:100/q:100/plain/https://dashboard.cellphones.com.vn/storage/Group2085661017.png',
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:595:100/q:100/plain/https://dashboard.cellphones.com.vn/storage/oppo-find-n6-open-cate.png',
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:595:100/q:100/plain/https://dashboard.cellphones.com.vn/storage/595x100_iPhone17ProMax_03.2026.png',
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:595:100/q:100/plain/https://dashboard.cellphones.com.vn/storage/x8d-cate.png',
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:595:100/q:100/plain/https://dashboard.cellphones.com.vn/storage/595x100_iPhone17ProMax_03.2026.png',
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:595:100/q:100/plain/https://dashboard.cellphones.com.vn/storage/samsung-galaxy-a37-cate.png',
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:595:100/q:100/plain/https://dashboard.cellphones.com.vn/storage/595x100_open_iPhone%2017e.png',
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:595:100/q:100/plain/https://dashboard.cellphones.com.vn/storage/Xiaomi17ultra_cate.png',
              ],
            ),
            AppText(
              text: controller.currentHeaderLabel,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: AppColors.gray900,
              textAlign: TextAlign.left,
            ),
            if (!controller.hasSelectedBrand) const BrandInCategoryList(),
            const SizedBox(height: 12),
            CriteriaList(
              isByPriceSelected:
                  controller.minPrice.value != null &&
                  controller.maxPrice.value != null,
              isReadySelected: controller.availableOnly.value,
              onByPriceTap: () async {
                final range = await Get.bottomSheet<PriceRange>(
                  PriceFilterPopUp(
                    categoryId: controller.categoryId.value,
                    brandId: controller.brandId.value,
                    initialMinPrice: controller.minPrice.value,
                    initialMaxPrice: controller.maxPrice.value,
                  ),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );

                if (range != null) {
                  // Apply only price range here. Keep sort direction as-is.
                  controller.applyPriceRange(
                    range,
                    controller.priceSortState.value,
                  );
                }
              },
              onReadyTap: controller.toggleAvailableOnly,
            ),
            FilterList(
              initialValue: controller.selectedFilter.value,
              hasActiveFilters: controller.showFilterBarBadge,
              onFilterTap: () async {
                controller.selectFilterTabOnly();
                await Get.bottomSheet<void>(
                  FilterPopUp(
                    categoryId: controller.categoryId.value,
                    brandId: controller.brandId.value,
                    initialMinPrice: controller.minPrice.value,
                    initialMaxPrice: controller.maxPrice.value,
                    initialAvailableOnly: controller.availableOnly.value,
                    initialAttributes: controller.appliedAttributesSnapshot,
                    onApply: controller.applyFilterSheet,
                  ),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              onChanged: controller.onSelectFilter,
            ),
            if (controller.isLoading.value)
              Skeletonizer(
                enabled: true,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.52,
                  ),
                  itemBuilder: (context, index) {
                    final product = ProductModel
                        .mockProducts[index % ProductModel.mockProducts.length];
                    return ProductItem(product: product);
                  },
                ),
              )
            else if (controller.products.isEmpty)
              AppText(
                text: 'No products',
                fontSize: 14,
                color: AppColors.gray600,
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.52,
                ),
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ProductItem(
                    product: product,
                    onTap: () => controller.goToProductDetail(product.id),
                  );
                },
              ),
            if (!controller.isLoading.value && controller.hasMoreProducts) ...[
              const SizedBox(height: 14),
              AppButton(
                text: controller.isLoadingMore.value
                    ? 'Loading...'
                    : 'See ${controller.remainingProductsCount} more products',
                onTap: controller.isLoadingMore.value
                    ? () {}
                    : controller.loadMoreProducts,
                disabled: controller.isLoadingMore.value,
                borderRadius: 10,
                height: 44,
                color: AppColors.white,
                disableColor: AppColors.gray200,
                textColor: AppColors.primary,
                disableTextColor: AppColors.gray500,
                border: Border.all(color: AppColors.gray300),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ],
            const SizedBox(height: 20),
            if (controller.isLoadingArticles.value)
              Skeletonizer(
                enabled: true,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.86,
                  ),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 180,
                  ),
                ),
              )
            else
              ArticleList(
                articles: controller.articles,
                onSeeAllTap: () {
                  Get.to(
                    () => const ArticleWebViewPage(
                      url: 'https://cellphones.com.vn/sforum',
                      title: 'Sforum',
                    ),
                  );
                },
                onArticleTap: (article) {
                  final link = article.link.trim();
                  if (link.isEmpty) return;
                  final uri = Uri.tryParse(link);
                  if (uri == null) return;
                  Get.to(
                    () => ArticleWebViewPage(
                      url: uri.toString(),
                      title: article.name,
                    ),
                  );
                },
              ),
            const SizedBox(height: 24),
            const FaqSection(),
          ],
        ),
      ),
    );
  }
}
