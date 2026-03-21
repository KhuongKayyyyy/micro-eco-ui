import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/components/base/base_screen.dart';
import 'package:ecommerce_app/components/general/app_text.dart';
import 'package:ecommerce_app/components/general/global_app_bar.dart';
import 'package:ecommerce_app/components/product/favorite_product_item.dart';
import 'package:ecommerce_app/screens/tab/favorite/favorite_screen_controller.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends BaseScreen<FavoriteScreenController> {
  const FavoriteScreen({super.key});

  @override
  Color? get backgroundColor => Colors.white;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return GlobalAppBar(title: context.tr('favorite.title'));
  }

  Widget _buildNoFavoriteProducts(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border_rounded,
              size: 76,
              color: Color(0xFFBDBDBD),
            ),
            const SizedBox(height: 24),
            AppText(
              text: context.tr('favorite.noSavedItems'),
              textAlign: TextAlign.center,
              fontSize: 22,
              height: 1.2,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
            const SizedBox(height: 14),
            AppText(
              text: context.tr('favorite.noFavoriteProducts'),
              textAlign: TextAlign.center,
              fontSize: 15,
              height: 1.35,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9E9E9E),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    final products = controller.favoriteProducts;
    if (products.isEmpty) {
      return _buildNoFavoriteProducts(context);
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 18,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        return FavoriteProductItem(product: products[index]);
      },
    );
  }
}
