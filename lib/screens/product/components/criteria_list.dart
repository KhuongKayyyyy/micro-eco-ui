import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class CriteriaList extends StatelessWidget {
  const CriteriaList({super.key});

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
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CriteriaItem(
                label: context.tr('productList.criteriaByPrice'),
                icon: Icons.sell_outlined,
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
  const _CriteriaItem({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.gray200.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.gray900),
            const SizedBox(width: 6),
            Flexible(
              child: AppText(
                text: label,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.gray900,
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
