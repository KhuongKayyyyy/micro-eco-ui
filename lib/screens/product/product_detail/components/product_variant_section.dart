import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class ProductStorageOption {
  const ProductStorageOption({required this.label, required this.selected});

  final String label;
  final bool selected;
}

class ProductColorOption {
  const ProductColorOption({
    required this.name,
    required this.image,
    required this.price,
    required this.selected,
  });

  final String name;
  final String image;
  final double price;
  final bool selected;
}

class ProductVariantSection extends StatelessWidget {
  const ProductVariantSection({
    super.key,
    required this.storageOptions,
    required this.selectedStorageIndex,
    required this.onStorageTap,
    required this.colorOptions,
    required this.selectedColorIndex,
    required this.onColorTap,
  });

  final List<ProductStorageOption> storageOptions;
  final int selectedStorageIndex;
  final ValueChanged<int> onStorageTap;
  final List<ProductColorOption> colorOptions;
  final int selectedColorIndex;
  final ValueChanged<int> onColorTap;

  @override
  Widget build(BuildContext context) {
    if (storageOptions.isEmpty && colorOptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (storageOptions.isNotEmpty) ...[
          AppText(
            text: context.tr('productDetail.storageVariants'),
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.gray900,
          ),
          const SizedBox(height: 7),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 7.0;
              final itemWidth = (constraints.maxWidth - (spacing * 2)) / 3;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (int i = 0; i < storageOptions.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: _StorageItem(
                        label: storageOptions[i].label,
                        selected: i == selectedStorageIndex,
                        onTap: () => onStorageTap(i),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
        ],
        if (colorOptions.isNotEmpty) ...[
          AppText(
            text: context.tr('productDetail.colorVariants'),
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.gray900,
          ),
          const SizedBox(height: 7),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 7.0;
              final itemWidth = (constraints.maxWidth - spacing) / 2;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (int i = 0; i < colorOptions.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: _ColorItem(
                        option: colorOptions[i],
                        selected: i == selectedColorIndex,
                        onTap: () => onColorTap(i),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }
}

class _StorageItem extends StatelessWidget {
  const _StorageItem({required this.label, required this.selected, this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: selected ? AppColors.statusError : AppColors.gray400,
                width: selected ? 2 : 1.2,
              ),
            ),
            child: AppText(
              text: label,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.gray900,
            ),
          ),
          if (selected)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  color: AppColors.statusError,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Icon(Icons.check, color: AppColors.white, size: 11),
              ),
            ),
        ],
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({required this.option, required this.selected, this.onTap});

  final ProductColorOption option;
  final bool selected;
  final VoidCallback? onTap;

  String _formatPrice(double price) {
    final fixed = price.toStringAsFixed(0);
    final withSeparators = fixed.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );
    return '$withSeparatorsđ';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? AppColors.statusError : AppColors.gray200,
                width: selected ? 2 : 1.2,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    option.image,
                    width: 31,
                    height: 31,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 31,
                      height: 31,
                      color: AppColors.gray100,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.gray500,
                        size: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: option.name,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray900,
                      ),
                      const SizedBox(height: 1),
                      AppText(
                        text: _formatPrice(option.price),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  color: AppColors.statusError,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Icon(Icons.check, color: AppColors.white, size: 11),
              ),
            ),
        ],
      ),
    );
  }
}
