import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';

/// Card network for the leading logo.
enum PaymentCardBrand {
  visa,
  mastercard;

  /// Rough BIN inference for common Visa / Mastercard ranges.
  static PaymentCardBrand fromCardNumber(String raw) {
    final d = raw.replaceAll(RegExp(r'\D'), '');
    if (d.isEmpty) return PaymentCardBrand.visa;
    if (d.startsWith('4')) return PaymentCardBrand.visa;
    if (d.startsWith('5')) return PaymentCardBrand.mastercard;
    if (d.length >= 4) {
      final four = int.tryParse(d.substring(0, 4));
      if (four != null && four >= 2221 && four <= 2720) {
        return PaymentCardBrand.mastercard;
      }
    }
    return PaymentCardBrand.visa;
  }
}

/// Single saved payment method row: brand logo, masked number, optional default chip, selection radio.
class PaymentCardComponent extends StatelessWidget {
  const PaymentCardComponent({
    super.key,
    required this.brand,
    required this.lastFourDigits,
    this.isDefault = false,
    this.isSelected = false,
    this.onTap,
  });

  final PaymentCardBrand brand;
  final String lastFourDigits;

  /// When true, shows a “Default” chip after the card number.
  final bool isDefault;

  final bool isSelected;
  final VoidCallback? onTap;

  static const double _logoSlotWidth = 56;

  String get _maskedNumber {
    final d = lastFourDigits.trim();
    final last = d.length >= 4 ? d.substring(d.length - 4) : d.padLeft(4, '0');
    return '**** **** **** $last';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.gray200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: _logoSlotWidth,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _PaymentBrandLogo(brand: brand),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: AppText(
                        text: _maskedNumber,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.gray900,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isDefault) ...[
                      const SizedBox(width: 8),
                      _PaymentDefaultBadge(
                        label: context.tr('addressBook.defaultBadge'),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _PaymentCardRadio(selected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentBrandLogo extends StatelessWidget {
  const _PaymentBrandLogo({required this.brand});

  final PaymentCardBrand brand;

  @override
  Widget build(BuildContext context) {
    switch (brand) {
      case PaymentCardBrand.visa:
        return AppText(
          text: 'VISA',
          fontSize: 17,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.6,
          color: AppColors.gray900,
        );
      case PaymentCardBrand.mastercard:
        return SizedBox(
          width: 40,
          height: 24,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gray900,
                  ),
                ),
              ),
              Positioned(
                left: 11,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gray900,
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}

class _PaymentDefaultBadge extends StatelessWidget {
  const _PaymentDefaultBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.gray200),
      ),
      child: AppText(
        text: label,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
    );
  }
}

class _PaymentCardRadio extends StatelessWidget {
  const _PaymentCardRadio({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.gray900 : AppColors.gray300,
                width: selected ? 2 : 1.5,
              ),
              color: AppColors.white,
            ),
          ),
          if (selected)
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray900,
              ),
            ),
        ],
      ),
    );
  }
}
