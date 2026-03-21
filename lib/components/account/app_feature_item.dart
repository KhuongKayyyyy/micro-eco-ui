import 'package:flutter/material.dart';

class AppFeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  bool isLastItem;

  AppFeatureItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(icon, size: 24, color: Colors.black),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  fontWeight: FontWeight.w900,
                  size: 30,
                  color: Color(0xFFBDBDBD),
                ),
              ],
            ),
          ),
        ),
        if (!isLastItem)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Divider(height: 1, thickness: 1),
          ),
      ],
    );
  }
}
