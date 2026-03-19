import 'package:ecommerce_app/model/product/favorite_product.dart';
import 'package:flutter/material.dart';

class FavoriteProductItem extends StatelessWidget {
  final FavoriteProduct product;

  const FavoriteProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1.35,
                  child: _buildImage(product.image),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Color(0xFFE53935),
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '\$ ${_formatPrice(product.price)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF777777),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildImage(String path) {
  final isNetwork = path.startsWith('http://') || path.startsWith('https://');
  if (isNetwork) {
    return Image.network(
      path,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF2F2F2)),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(color: const Color(0xFFF2F2F2));
      },
    );
  }

  return Image.asset(
    path,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF2F2F2)),
  );
}

String _formatPrice(double price) {
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
