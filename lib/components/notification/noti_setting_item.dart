import 'package:flutter/material.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';

class NotiSettingItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isLastItem;
  final ValueChanged<bool>? onChanged;

  const NotiSettingItem({
    super.key,
    required this.title,
    required this.isSelected,
    this.isLastItem = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isLastItem)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEDED)),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: isSelected,
                onChanged: onChanged,
                activeColor: AppColors.primary,
                inactiveTrackColor: AppColors.gray300,
                inactiveThumbColor: AppColors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
