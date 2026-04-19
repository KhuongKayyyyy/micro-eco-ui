import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class CriteriaList extends StatelessWidget {
  const CriteriaList({
    super.key,
    this.onByPriceTap,
    this.isByPriceSelected = false,
    this.onReadyTap,
    this.isReadySelected = false,
  });

  final VoidCallback? onByPriceTap;
  final bool isByPriceSelected;
  final VoidCallback? onReadyTap;
  final bool isReadySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: context.tr('productList.criteriaTitle'),
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.gray900,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _CriteriaItem(
                label: context.tr('productList.criteriaReady'),
                icon: Icons.local_shipping_outlined,
                onTap: onReadyTap,
                isActive: isReadySelected,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CriteriaItem(
                label: context.tr('productList.criteriaByPrice'),
                icon: Icons.sell_outlined,
                onTap: onByPriceTap,
                isActive: isByPriceSelected,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CriteriaItem(
                label: context.tr('productList.criteriaNewArrival'),
                icon: Icons.inventory_2_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CriteriaItem extends StatelessWidget {
  const _CriteriaItem({
    required this.label,
    required this.icon,
    this.onTap,
    this.isActive = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.sub.withValues(alpha: 0.18)
              : AppColors.gray200.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppColors.sub : Colors.transparent,
            width: isActive ? 1 : 0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppColors.sub : AppColors.gray900,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: AppText(
                text: label,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? AppColors.sub : AppColors.gray900,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
