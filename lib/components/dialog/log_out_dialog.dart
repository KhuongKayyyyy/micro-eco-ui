import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';

class LogOutDialog extends StatelessWidget {
  final VoidCallback? onLogout;
  final VoidCallback? onCancel;
  final String? title;
  final String? description;

  const LogOutDialog({
    super.key,
    this.onLogout,
    this.onCancel,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final red = AppColors.statusError;

    final logoutTitle = title ?? '${context.tr('account.logout')}?';
    final logoutDescription = description ?? 'Are you sure you want to logout?';

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 420,
          minWidth: 280,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: red, width: 7),
                ),
              ),
              Text(
                '!',
                style: TextStyle(
                  color: red,
                  fontSize: 56,
                  height: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AppText(
            text: logoutTitle,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          const SizedBox(height: 12),
          AppText(
            text: logoutDescription,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.gray600,
            textAlign: TextAlign.center,
            height: 1.4,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                onLogout?.call();
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: AppText(
                text: 'Yes, ${context.tr('account.logout')}',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton(
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop(false);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: BorderSide(color: AppColors.gray300, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: AppText(
                text: 'No, ${context.tr('buttonAction.cancel')}',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }
}
