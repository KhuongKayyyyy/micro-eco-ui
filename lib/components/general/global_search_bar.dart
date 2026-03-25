import 'package:flutter/material.dart';

class GlobalSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onMicPressed;

  const GlobalSearchBar({
    super.key,
    this.hintText = 'Search for questions...',
    this.controller,
    this.onChanged,
    this.onMicPressed,
  });

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFEDEDED);
    const radius = 16.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFFBDBDBD),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 26,
            color: Color(0xFFA5A5A5),
          ),
          suffixIcon: IconButton(
            onPressed: onMicPressed,
            icon: const Icon(
              Icons.mic_none_outlined,
              size: 26,
              color: Color(0xFFA5A5A5),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
