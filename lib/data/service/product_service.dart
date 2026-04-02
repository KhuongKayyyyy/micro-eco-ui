import 'package:ecommerce_app/model/product/favorite_product.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';
import 'package:ecommerce_app/model/product/product_model.dart';

class ProductService {
  static List<FavoriteProduct> getFavoriteProducts() {
    return FavoriteProduct.mockFavoriteProducts.toList();
    // return [];
  }

  static Future<List<ProductCategory>> getProductCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    // Home chips: show Electronics level-1 categories (Smartphones / Watch / Headphones ...).
    return ProductCategory.electronicsRootCategories.toList();
  }

  static Future<List<ProductModel>> getProducts(String categoryId) async {
    await Future.delayed(const Duration(seconds: 2));
    return ProductModel.mockProducts.toList();
  }
}
