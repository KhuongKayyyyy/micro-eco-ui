import 'dart:convert';

import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';
import 'package:flutter/material.dart';

class SearchRootCategoryItem extends StatelessWidget {
  const SearchRootCategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });

  final ProductCategory category;
  final bool isSelected;
  final VoidCallback? onTap;

  Widget _buildCategoryImage() {
    final src = category.image.trim();

    // Handle `data:image/...;base64,...` from API.
    if (src.startsWith('data:image')) {
      final idx = src.indexOf(',');
      if (idx >= 0 && idx + 1 < src.length) {
        try {
          final bytes = base64Decode(src.substring(idx + 1));
          return Image.memory(
            bytes,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const _ImageFallback(),
          );
        } catch (_) {
          return const _ImageFallback();
        }
      }
    }

    if (src.startsWith('http://') || src.startsWith('https://')) {
      return Image.network(
        src,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const _ImageFallback(),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const _ImageFallback();
        },
      );
    }

    if (src.isNotEmpty) {
      return Image.asset(
        src,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const _ImageFallback(),
      );
    }

    return const _ImageFallback();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.white : AppColors.gray100,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: isSelected ? AppColors.statusError : AppColors.gray200,
                width: isSelected ? 3 : 1,
              ),
              bottom: BorderSide(color: AppColors.gray200, width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: _buildCategoryImage(),
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: AppText(
                  text: category.name,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: AppColors.gray900,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray200,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 20,
        color: AppColors.gray500,
      ),
    );
  }
}
