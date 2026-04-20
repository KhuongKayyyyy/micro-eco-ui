import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/brand/brand_model.dart';
import 'package:ecommerce_app/screens/product/product_list/product_list_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandInCategoryList extends GetView<ProductListPageController> {
  const BrandInCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final brands = controller.brands;
      final topBrands = brands.take(3).toList();
      final hasMoreThanThreeBrands = brands.length > 3;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          if (topBrands.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final brand in topBrands)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _BrandPill(
                        brand: brand,
                        onTap: () => controller.onSelectBrand(brand),
                      ),
                    ),
                  if (hasMoreThanThreeBrands)
                    _ViewAllPill(
                      label: context.tr('productList.viewAll'),
                      onTap: () => _openBrandBottomSheet(context),
                    ),
                ],
              ),
            ),
        ],
      );
    });
  }

  void _openBrandBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.72,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const SizedBox(width: 32),
                        Expanded(
                          child: AppText(
                            text: context.tr('productList.selectByBrand'),
                            textAlign: TextAlign.center,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded, size: 22),
                          color: AppColors.gray500,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          const columns = 4;
                          const spacing = 6.0;
                          final itemWidth =
                              (constraints.maxWidth -
                                  (spacing * (columns - 1))) /
                              columns;
                          return SingleChildScrollView(
                            child: Wrap(
                              spacing: spacing,
                              runSpacing: spacing,
                              children: [
                                for (final brand in controller.brands)
                                  _BrandPill(
                                    brand: brand,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      controller.onSelectBrand(brand);
                                    },
                                    minWidth: itemWidth,
                                    maxWidth: itemWidth,
                                    height: 38,
                                    horizontalPadding: 6,
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: AppButton(
                      text: context.tr('productList.close'),
                      color: AppColors.primary,
                      borderRadius: 12,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ViewAllPill extends StatelessWidget {
  const _ViewAllPill({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(minWidth: 96),
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray200),
          color: AppColors.white,
        ),
        alignment: Alignment.center,
        child: AppText(text: label, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _BrandPill extends StatelessWidget {
  const _BrandPill({
    required this.brand,
    this.onTap,
    this.minWidth = 88,
    this.maxWidth = 148,
    this.height = 50,
    this.horizontalPadding = 10,
  });

  final BrandModel brand;
  final VoidCallback? onTap;
  final double minWidth;
  final double maxWidth;
  final double height;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth),
        height: height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray200),
          color: AppColors.white,
        ),
        alignment: Alignment.center,
        child: _BrandContent(brand: brand),
      ),
    );
  }
}

class _BrandContent extends StatelessWidget {
  const _BrandContent({required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    if (brand.image.isNotEmpty) {
      if (brand.image.startsWith('http://') ||
          brand.image.startsWith('https://')) {
        return Image.network(
          brand.image,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _BrandLabel(text: brand.name),
          loadingBuilder: (context, child, progress) =>
              progress == null ? child : _BrandLabel(text: brand.name),
        );
      }
      return Image.asset(
        brand.image,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _BrandLabel(text: brand.name),
      );
    }

    return _BrandLabel(text: brand.name);
  }
}

class _BrandLabel extends StatelessWidget {
  const _BrandLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.gray900,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
