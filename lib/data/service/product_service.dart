import 'package:ecommerce_app/model/product/favorite_product.dart';
import 'package:ecommerce_app/data/service/product_category_service.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';
import 'package:ecommerce_app/model/product/product_model.dart';

class ProductService {
  static List<FavoriteProduct> getFavoriteProducts() {
    return FavoriteProduct.mockFavoriteProducts.toList();
    // return [];
  }

  static Future<List<ProductCategory>> getProductCategories() async {
    try {
      // Real microservice call.
      return await ProductCategoryService.getRootProductCategories();
    } catch (_) {
      // Local fallback so UI still works when backend is unavailable.
      await Future.delayed(const Duration(seconds: 2));
      return ProductCategory.electronicsRootCategories.toList();
    }
  }

  static Future<List<ProductModel>> getProducts(String categoryId) async {
    await Future.delayed(const Duration(seconds: 2));
    return ProductModel.mockProducts.toList();
  }
}
