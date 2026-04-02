import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';
import 'package:flutter/material.dart';

/// Rounded category chip: unselected = white + gray border; selected = black + white text.
class ProductCategoryItem extends StatelessWidget {
  const ProductCategoryItem({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  final ProductCategory category;
  final bool isSelected;
  final VoidCallback? onTap;

  static const double _radius = 14;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_radius),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.gray900 : AppColors.white,
            borderRadius: BorderRadius.circular(_radius),
            border: Border.all(
              color: isSelected ? AppColors.gray900 : AppColors.gray200,
              width: 1,
            ),
          ),
          child: AppText(
            text: category.name,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : AppColors.gray900,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
