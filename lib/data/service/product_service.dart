import 'package:ecommerce_app/constants/api_path.dart';
import 'package:ecommerce_app/constants/app_env.dart';
import 'package:ecommerce_app/data/dio/dio_service.dart';
import 'package:ecommerce_app/model/product/favorite_product.dart';
import 'package:ecommerce_app/data/service/product_category_service.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';
import 'package:ecommerce_app/model/product/product_model.dart';
import 'package:get/get.dart';

class ProductSearchResult {
  final List<ProductModel> items;
  final int totalElements;
  final bool isLastPage;

  ProductSearchResult({
    required this.items,
    required this.totalElements,
    required this.isLastPage,
  });
}

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

  static Future<ProductSearchResult> searchProduct({
    String? categoryId,
    String? brandId,
    double? minPrice,
    double? maxPrice,
    int? page,
    int? size,
    String? sortBy,
    String? sortDirection,
  }) async {
    final params = <String, dynamic>{
      if (categoryId != null && categoryId.trim().isNotEmpty)
        'categoryId': categoryId.trim(),
      if (brandId != null && brandId.trim().isNotEmpty) 'brandId': brandId.trim(),
      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,
      if (page != null) 'page': page,
      if (size != null) 'size': size,
      if (sortBy != null && sortBy.trim().isNotEmpty) 'sortBy': sortBy.trim(),
      if (sortDirection != null && sortDirection.trim().isNotEmpty)
        'sortDirection': sortDirection.trim(),
    };

    final response = await Get.find<DioService>().get<Map<String, dynamic>>(
      baseUrl: AppEnv.productServiceBaseUrl,
      path: ApiPath.productSearch,
      parameters: params.isEmpty ? null : params,
    );

    final content = response['content'];
    final items = content is List
        ? content
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList()
        : <ProductModel>[];

    final total = response['totalElements'];
    final totalElements = total is num
        ? total.toInt()
        : int.tryParse(total?.toString() ?? '') ?? items.length;
    final last = response['last'] == true;

    return ProductSearchResult(
      items: items,
      totalElements: totalElements,
      isLastPage: last,
    );
  }
}
