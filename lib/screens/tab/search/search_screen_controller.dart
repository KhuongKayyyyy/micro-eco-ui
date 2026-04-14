import 'package:get/get.dart';
import 'package:ecommerce_app/data/service/brand_service.dart';
import 'package:ecommerce_app/data/service/product_category_service.dart';
import 'package:ecommerce_app/model/brand/brand_model.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';

class SearchScreenController extends GetxController {
  final isLoadingRootCategories = true.obs;
  final rootCategories = <ProductCategory>[].obs;
  final selectedRootCategoryId = RxnString();
  final isLoadingBrands = true.obs;
  final brands = <BrandModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRootCategories();
  }

  Future<void> fetchRootCategories() async {
    isLoadingRootCategories.value = true;
    try {
      final list = await ProductCategoryService.getRootProductCategories();
      rootCategories.assignAll(list);
      if (list.isNotEmpty) {
        selectedRootCategoryId.value ??= list.first.id;
        await fetchBrandsByCategory(list.first.id);
      } else {
        brands.clear();
      }
    } catch (_) {
      // Keep screen stable if API is unavailable; show empty list for now.
      rootCategories.clear();
      selectedRootCategoryId.value = null;
      brands.clear();
    } finally {
      isLoadingRootCategories.value = false;
    }
  }

  Future<void> selectRootCategory(String id) async {
    selectedRootCategoryId.value = id;
    await fetchBrandsByCategory(id);
  }

  Future<void> fetchBrandsByCategory(String categoryId) async {
    isLoadingBrands.value = true;
    try {
      final list = await BrandService.getBrandsByCategory(categoryId);
      brands.assignAll(list);
    } catch (_) {
      brands.clear();
    } finally {
      isLoadingBrands.value = false;
    }
  }
}
