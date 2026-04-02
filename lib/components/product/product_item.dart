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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: AppColors.gray100,
                  padding: const EdgeInsets.all(12),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _buildImage(product.image),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 22,
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
          const SizedBox(height: 12),
          AppText(
            text: product.name,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.gray900,
            maxLines: 1,
          ),
          const SizedBox(height: 6),
          if (_hasDiscount)
            Row(
              children: [
                AppText(
                  text: '\$ ${_formatPrice(_displayPrice)}',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray900,
                ),
                const SizedBox(width: 8),
                AppText(
                  text: '\$ ${_formatPrice(product.price)}',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray400,
                  textDecoration: TextDecoration.lineThrough,
                ),
              ],
            )
          else
            AppText(
              text: '\$ ${_formatPrice(_displayPrice)}',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF777777),
            ),
        ],
      ),
    );
  }
}
