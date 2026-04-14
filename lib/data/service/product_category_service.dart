import 'package:ecommerce_app/constants/api_path.dart';
import 'package:ecommerce_app/constants/app_env.dart';
import 'package:ecommerce_app/data/dio/dio_service.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';
import 'package:get/get.dart';

class ProductCategoryService {
  static Future<List<ProductCategory>> getRootProductCategories() async {
    final response = await Get.find<DioService>().get<List<dynamic>>(
      baseUrl: AppEnv.productServiceBaseUrl,
      path: ApiPath.rootProductCategories,
    );
    return response
        .map((e) => ProductCategory.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
