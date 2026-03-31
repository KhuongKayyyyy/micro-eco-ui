import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/constants/app_color.dart';
import 'package:ecommerce_app/model/cart/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class CartItemComponent extends StatelessWidget {
  final CartModel cart;
  final VoidCallback? onDelete;
  final VoidCallback? onSimilarProduct;
  final VoidCallback? onIncreaseQty;
  final VoidCallback? onDecreaseQty;

  const CartItemComponent({
    super.key,
    required this.cart,
    this.onDelete,
    this.onSimilarProduct,
    this.onIncreaseQty,
    this.onDecreaseQty,
  });

  String _formatPrice(double price) {
    return '\$ ${NumberFormat('#,###').format(price)}';
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(cart.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.45,
        children: [
          SlidableAction(
            onPressed: (_) => onSimilarProduct?.call(),
            backgroundColor: const Color(0xFF4C6EF5),
            foregroundColor: Colors.white,
            label: 'Similar\nproduct',
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(14),
            ),
          ),
          SlidableAction(
            onPressed: (_) => onDelete?.call(),
            backgroundColor: AppColors.statusError,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline_rounded,
            label: 'Delete',
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(14),
            ),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.gray200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _CartImage(imagePath: cart.image),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppText(
                          text: cart.name,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray900,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onDelete,
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.statusError,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    text: cart.description,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray500,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: _formatPrice(cart.price),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.gray900,
                        ),
                      ),
                      _QtyButton(
                        icon: Icons.remove_rounded,
                        onTap: onDecreaseQty,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: AppText(
                          text: '${cart.quantity}',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray900,
                        ),
                      ),
                      _QtyButton(icon: Icons.add_rounded, onTap: onIncreaseQty),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.gray300),
          color: AppColors.white,
        ),
        child: Icon(icon, color: AppColors.gray900, size: 24),
      ),
    );
  }
}

class _CartImage extends StatelessWidget {
  const _CartImage({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final isRemote =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');
    final imageWidget = isRemote
        ? Image.network(imagePath, fit: BoxFit.cover)
        : Image.asset(imagePath, fit: BoxFit.cover);

    return SizedBox(width: 96, height: 96, child: imageWidget);
  }
}
