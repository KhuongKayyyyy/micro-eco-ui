import 'package:ecommerce_app/constants/api_path.dart';
import 'package:ecommerce_app/constants/app_env.dart';
import 'package:ecommerce_app/data/dio/dio_service.dart';
import 'package:ecommerce_app/model/article/article_model.dart';
import 'package:get/get.dart';

class ArticleService {
  static Future<List<ArticleModel>> getArticlesByCategory(String categoryId) async {
    final response = await Get.find<DioService>().get<List<dynamic>>(
      baseUrl: AppEnv.productServiceBaseUrl,
      path: ApiPath.articleByCategory.replaceAll('{categoryId}', categoryId),
    );
    return response
        .whereType<Map<String, dynamic>>()
        .map(ArticleModel.fromJson)
        .toList();
  }
}
