import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/product/product_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onTap,
  });

  final ProductModel product;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTap;

  bool get _hasDiscount =>
      product.discountPrice > 0 && product.discountPrice < product.price;

  double get _displayPrice =>
      _hasDiscount ? product.discountPrice : product.price;

  double get _studentDiscount => product.price * 0.03;

  String _formatPrice(double price) {
    // Keep formatting consistent with `FavoriteProductItem`.
    final isWhole = price % 1 == 0;
    final raw = isWhole ? price.toStringAsFixed(0) : price.toStringAsFixed(2);
    final parts = raw.split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (m) => ',',
    );
    if (parts.length == 1) return intPart;
    return '$intPart.${parts[1]}';
  }

  Widget _buildImage(String path) {
    final isNetwork = path.startsWith('http://') || path.startsWith('https://');
    if (isNetwork) {
      return Image.network(
        path,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(color: AppColors.gray100),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(color: AppColors.gray100);
        },
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(color: AppColors.gray100),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = product.price == 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: AppColors.gray100,
                      padding: const EdgeInsets.all(10),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: _buildImage(product.image),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF1FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AppText(
                        text: context.tr('productList.taxLabel'),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF3A6FD7),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 18,
                        onPressed: onFavoriteTap,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: const Color(0xFFE53935),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AppText(
                text: product.name,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
                maxLines: 2,
              ),
              const SizedBox(height: 6),
              if (isOutOfStock)
                AppText(
                  text: context.tr('productList.outOfStock'),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray400,
                )
              else if (_hasDiscount)
                Row(
                  children: [
                    AppText(
                      text: '${_formatPrice(_displayPrice)}đ',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE53935),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppText(
                        text: '${_formatPrice(product.price)}đ',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray400,
                        textDecoration: TextDecoration.lineThrough,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              else
                AppText(
                  text: '${_formatPrice(_displayPrice)}đ',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE53935),
                ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1ECFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isOutOfStock
                    ? AppText(
                        text: context.tr('productList.contactToBuy'),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5B3BC4),
                        maxLines: 2,
                      )
                    : AppText(
                        text: context.tr(
                          'productList.studentDiscount',
                          namedArgs: {
                            'amount': '${_formatPrice(_studentDiscount)}đ',
                          },
                        ),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5B3BC4),
                        maxLines: 2,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
