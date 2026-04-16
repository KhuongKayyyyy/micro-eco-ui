import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';

enum ProductFilterType { popular, promotion, price, filter }

enum PriceSortState { none, desc, asc }

class FilterSelection {
  final ProductFilterType type;
  final PriceSortState priceSortState;

  const FilterSelection({required this.type, required this.priceSortState});
}

class FilterList extends StatefulWidget {
  const FilterList({
    super.key,
    this.onChanged,
    this.initialValue,
    this.isPriceRangeApplied = false,
  });

  final ValueChanged<FilterSelection>? onChanged;
  final ProductFilterType? initialValue;
  final bool isPriceRangeApplied;

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  late ProductFilterType selected;
  PriceSortState priceSortState = PriceSortState.none;

  @override
  void initState() {
    super.initState();
    selected = widget.initialValue ?? ProductFilterType.popular;
  }

  @override
  void didUpdateWidget(covariant FilterList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        selected = widget.initialValue ?? ProductFilterType.popular;
        if (selected != ProductFilterType.price) {
          priceSortState = PriceSortState.none;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPriceTabActive =
        selected == ProductFilterType.price ||
        priceSortState != PriceSortState.none;

    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          SizedBox(
            height: 46,
            child: Row(
              children: [
                Expanded(
                  child: _FilterTab(
                    label: context.tr('productList.filterPopular'),
                    isActive: selected == ProductFilterType.popular,
                    onTap: () => _onSelect(ProductFilterType.popular),
                  ),
                ),
                const _DividerLine(),
                Expanded(
                  child: _FilterTab(
                    label: context.tr('productList.filterPromotion'),
                    isActive: selected == ProductFilterType.promotion,
                    onTap: () => _onSelect(ProductFilterType.promotion),
                  ),
                ),
                const _DividerLine(),
                Expanded(
                  child: _FilterTab(
                    label: context.tr('productList.filterPrice'),
                    isActive: isPriceTabActive,
                    suffixIcon: _priceSortIcon,
                    onTap: _onPriceTap,
                  ),
                ),
                const _DividerLine(),
                Expanded(
                  child: _FilterTab(
                    label: context.tr('productList.filter'),
                    isActive: selected == ProductFilterType.filter,
                    suffixIcon: Icons.filter_alt_rounded,
                    showDotOnIcon: widget.isPriceRangeApplied,
                    onTap: () => _onSelect(ProductFilterType.filter),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
        ],
      ),
    );
  }

  void _onSelect(ProductFilterType type) {
    if (selected == type) return;
    setState(() {
      selected = type;
      if (type != ProductFilterType.price) {
        priceSortState = PriceSortState.none;
      }
    });
    widget.onChanged?.call(
      FilterSelection(type: selected, priceSortState: priceSortState),
    );
  }

  void _onPriceTap() {
    setState(() {
      if (priceSortState == PriceSortState.none) {
        priceSortState = PriceSortState.desc;
        selected = ProductFilterType.price;
      } else if (priceSortState == PriceSortState.desc) {
        priceSortState = PriceSortState.asc;
        selected = ProductFilterType.price;
      } else {
        priceSortState = PriceSortState.none;
        selected = ProductFilterType.popular;
      }
    });
    widget.onChanged?.call(
      FilterSelection(type: selected, priceSortState: priceSortState),
    );
  }

  IconData get _priceSortIcon {
    switch (priceSortState) {
      case PriceSortState.desc:
        return Icons.arrow_downward_rounded;
      case PriceSortState.asc:
        return Icons.arrow_upward_rounded;
      case PriceSortState.none:
        return Icons.unfold_more_rounded;
    }
  }
}

class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    this.isActive = false,
    this.suffixIcon,
    this.onTap,
    this.showDotOnIcon = false,
  });

  final String label;
  final bool isActive;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final bool showDotOnIcon;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final inactiveColor = AppColors.gray500;
    final textColor = isActive ? activeColor : inactiveColor;

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: label,
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: textColor,
                ),
                if (suffixIcon != null) ...[
                  const SizedBox(width: 2),
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Icon(suffixIcon, size: 20, color: textColor),
                        ),
                        if (showDotOnIcon)
                          const Positioned(top: -2, right: -2, child: _Dot()),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isActive)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(height: 2, color: activeColor),
            ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 24, color: AppColors.gray300);
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.statusWarn,
      ),
    );
  }
}
