import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/app_button.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class SucessDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String buttonText;
  final VoidCallback onButtonTap;
  const SucessDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.buttonText,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.statusSuccess, width: 5),
                shape: BoxShape.circle,
                color: const Color(0xFFE6F4EA),
              ),
              child: Icon(
                Icons.check,
                color: AppColors.statusSuccess,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            AppText(
              text: title,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
            ),
            const SizedBox(height: 12),
            AppText(
              text: subtitle ?? context.tr('passwordChanged.subtitle'),
              textAlign: TextAlign.center,
              fontSize: 14,
              color: AppColors.gray500,
            ),
            const SizedBox(height: 24),

            AppButton(text: buttonText, onTap: onButtonTap),
          ],
        ),
      ),
    );
  }
}
