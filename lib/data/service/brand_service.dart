import 'package:ecommerce_app/constants/api_path.dart';
import 'package:ecommerce_app/constants/app_env.dart';
import 'package:ecommerce_app/model/brand/brand_model.dart';
import 'package:get/get.dart';

import '../dio/dio_service.dart';

class BrandService {
  static Future<List<BrandModel>> getBrands() async {
    final response = await Get.find<DioService>().get<List<dynamic>>(
      baseUrl: AppEnv.productServiceBaseUrl,
      path: ApiPath.brands,
    );
    return response.map((e) => BrandModel.fromJson(e)).toList();
  }

  static Future<List<BrandModel>> getBrandsByCategory(String category) async {
    final response = await Get.find<DioService>().get<List<dynamic>>(
      baseUrl: AppEnv.productServiceBaseUrl,
      path: ApiPath.brandByCategory.replaceAll('{category}', category),
    );
    return response.map((e) => BrandModel.fromJson(e)).toList();
  }
}
