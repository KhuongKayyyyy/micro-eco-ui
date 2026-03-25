import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:flutter/material.dart';

import 'help_center_screen_controller.dart';

class HelpCenterScreen extends BaseScreen<HelpCenterScreenController> {
  const HelpCenterScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(
      title: context.tr('account.helpCenter'),
      isTitleCenter: true,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    const horizontalPadding = 20.0;
    const verticalGap = 14.0;

    final items = <_HelpCenterItem>[
      _HelpCenterItem(
        icon: Icons.headset_mic_outlined,
        label: 'Customer Service',
      ),
      _HelpCenterItem(icon: Icons.message_outlined, label: 'Whatsapp'),
      _HelpCenterItem(icon: Icons.language_outlined, label: 'Website'),
      _HelpCenterItem(icon: Icons.facebook, label: 'Facebook'),
      _HelpCenterItem(icon: Icons.public_outlined, label: 'Twitter'),
      _HelpCenterItem(icon: Icons.camera_alt_outlined, label: 'Instagram'),
    ];

    return Column(
      children: [
        const Divider(
          // A subtle divider under the app bar
          color: Color(0xFFEDEDED),
          thickness: 1,
          height: 1,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 12,
            ),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: i == items.length - 1 ? 0 : verticalGap,
                    ),
                    child: _HelpCenterCard(item: items[i]),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HelpCenterItem {
  final IconData icon;
  final String label;

  const _HelpCenterItem({required this.icon, required this.label});
}

class _HelpCenterCard extends StatelessWidget {
  final _HelpCenterItem item;

  const _HelpCenterCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1),
      ),
      child: Row(
        children: [
          Icon(item.icon, size: 26, color: Colors.black),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              item.label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
