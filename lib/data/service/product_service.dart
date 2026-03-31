import 'package:ecommerce_app/model/product/favorite_product.dart';

class ProductService {
  static List<FavoriteProduct> getFavoriteProducts() {
    return FavoriteProduct.mockFavoriteProducts.toList();
    // return [];
  }
}
