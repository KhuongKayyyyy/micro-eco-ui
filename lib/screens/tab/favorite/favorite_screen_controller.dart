import 'package:ecommerce_app/data/serivce/product_service.dart';
import 'package:ecommerce_app/model/product/favorite_product.dart';
import 'package:get/get.dart';

class FavoriteScreenController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<FavoriteProduct> favoriteProducts =
      ProductService.getFavoriteProducts();
}
