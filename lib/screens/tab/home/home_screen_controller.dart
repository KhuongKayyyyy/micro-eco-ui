import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/screens/tab/tab_controller.dart';
import 'package:ecommerce_app/data/service/product_service.dart';
import 'package:ecommerce_app/model/product/product_catergory.dart';
import 'package:ecommerce_app/model/product/product_model.dart';

class HomeScreenController extends GetxController {
  final isLoadingCategories = true.obs;
  final categories = <ProductCategory>[].obs;
  final selectedCategoryIndex = 0.obs; // 0 = "All"

  final isLoadingProducts = true.obs;
  final products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductCategories();
    fetchProducts('all');
  }

  Future<void> fetchProductCategories() async {
    isLoadingCategories.value = true;
    try {
      final result = await ProductService.getProductCategories();
      categories.assignAll(result);
      selectedCategoryIndex.value = 0;
    } finally {
      isLoadingCategories.value = false;
    }
  }

  void onProductCategorySelected(int index) {
    selectedCategoryIndex.value = index;
    final categoryId = _categoryIdFromIndex(index);
    fetchProducts(categoryId);
  }

  String _categoryIdFromIndex(int index) {
    if (index <= 0) return 'all';
    final i = index - 1;
    if (i < 0 || i >= categories.length) return 'all';
    return categories[i].id;
  }

  Future<void> fetchProducts(String categoryId) async {
    isLoadingProducts.value = true;
    try {
      final list = await ProductService.getProducts(categoryId);
      products.assignAll(list);
    } finally {
      isLoadingProducts.value = false;
    }
  }

  void navigateToNotificationScreen() {
    final tabController = Get.find<TabScreenController>();
    Get.toNamed(
      AppRoutes.notification,
      id: tabController.navigatorIdForTab(TabType.home),
    );
  }
}
