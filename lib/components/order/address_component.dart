import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/address_model.dart';
import 'package:flutter/material.dart';

String _formatPhoneDisplay(String raw) {
  final digits = raw.replaceAll(RegExp(r'\D'), '');
  if (digits.length == 10) {
    return '${digits.substring(0, 3)}-${digits.substring(3, 6)}-${digits.substring(6)}';
  }
  if (digits.length == 11 && digits.startsWith('0')) {
    return '${digits.substring(0, 4)}-${digits.substring(4, 7)}-${digits.substring(7)}';
  }
  return raw;
}

class AddressComponent extends StatelessWidget {
  const AddressComponent({
    super.key,
    required this.address,
    required this.selected,
    this.onSelect,
    this.onEdit,
  });

  final AddressModel address;
  final bool selected;
  final VoidCallback? onSelect;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final title = '${address.name} | ${_formatPhoneDisplay(address.phone)}';

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Move the radio button to the left
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: _AddressRadio(selected: selected, onTap: onSelect),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: AppText(
                              text: title,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.gray900,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (address.isDefault) ...[
                            const SizedBox(width: 8),
                            _DefaultBadge(
                              label: context.tr('addressBook.defaultBadge'),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onEdit,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            foregroundColor: AppColors.gray900,
                          ),
                          child: AppText(
                            text: context.tr('buttonAction.edit'),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray900,
                          ),
                        ),
                        // Remove radio from here
                        // const SizedBox(height: 2),
                        // _AddressRadio(selected: selected, onTap: onSelect),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                AppText(
                  text: address.address,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultBadge extends StatelessWidget {
  const _DefaultBadge({required this.label});

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

class _AddressRadio extends StatelessWidget {
  const _AddressRadio({required this.selected, this.onTap});

  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
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
                border: Border.all(color: AppColors.gray900, width: 2),
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
      ),
    );
  }
}
