import 'package:ecommerce_app/data/service/brand_service.dart';
import 'package:ecommerce_app/data/service/product_category_service.dart';
import 'package:ecommerce_app/data/service/product_service.dart';
import 'package:ecommerce_app/model/brand/brand_model.dart';
import 'package:ecommerce_app/model/product/product_model.dart';
import 'package:ecommerce_app/screens/product/components/filter_list.dart';
import 'package:get/get.dart';

class ProductListPageController extends GetxController {
  static const int _initialPageSize = 10;
  static const int _loadMorePageSize = 20;

  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final products = <ProductModel>[].obs;
  final brands = BrandModel.mockBrands.toList().obs;
  final isLoadingBrands = false.obs;
  final categoryId = RxnString();
  final categoryName = RxnString();
  final brandId = RxnString();
  final selectedFilter = ProductFilterType.popular.obs;
  final priceSortState = PriceSortState.none.obs;
  final totalElements = 0.obs;
  bool get hasSelectedBrand =>
      brandId.value != null && brandId.value!.trim().isNotEmpty;
  String get currentHeaderLabel {
    if (hasSelectedBrand) {
      final id = brandId.value;
      final selectedBrand = brands.firstWhereOrNull((e) => e.id == id);
      return selectedBrand?.name ?? id ?? '-';
    }

    final cName = categoryName.value?.trim();
    if (cName != null && cName.isNotEmpty) return cName;
    return categoryId.value ?? '-';
  }

  bool get hasMoreProducts => products.length < totalElements.value;
  int get remainingProductsCount {
    final remaining = totalElements.value - products.length;
    return remaining > 0 ? remaining : 0;
  }

  int _requestedSize = _initialPageSize;

  @override
  void onInit() {
    super.onInit();
    _applyRouteArguments(_currentRoutePayload);
    _resolveCategoryNameById();
    _loadBrands();
    fetchProducts();
  }

  @override
  void onReady() {
    super.onReady();

    // Apply lần đầu
    applyRouteArguments(_currentRoutePayload);

    // Lắng nghe khi route thay đổi
    ever(Get.routing.obs, (_) {
      applyRouteArguments(_currentRoutePayload);
    });
  }

  String? _normalizeNullable(dynamic raw) {
    if (raw == null) return null;
    final value = raw.toString().trim();
    if (value.isEmpty || value.toLowerCase() == 'null') return null;
    return value;
  }

  Map<String, dynamic> get _currentRoutePayload {
    final payload = <String, dynamic>{};
    if (Get.parameters.isNotEmpty) {
      payload.addAll(Get.parameters);
    }
    final arguments = Get.arguments;
    if (arguments is Map) {
      payload.addAll(
        arguments.map((key, value) => MapEntry(key.toString(), value)),
      );
    }
    return payload;
  }

  void _applyRouteArguments(dynamic args) {
    if (args is! Map) return;
    categoryId.value = _normalizeNullable(args['categoryId']);
    categoryName.value = _normalizeNullable(args['categoryName']);
    brandId.value = _normalizeNullable(args['brandId']);
  }

  Future<void> applyRouteArguments(dynamic args) async {
    if (args is! Map) return;

    final nextCategoryId = _normalizeNullable(args['categoryId']);
    final nextCategoryName = _normalizeNullable(args['categoryName']);
    final nextBrandId = _normalizeNullable(args['brandId']);

    final changed =
        nextCategoryId != categoryId.value ||
        nextCategoryName != categoryName.value ||
        nextBrandId != brandId.value;

    if (!changed) return;

    categoryId.value = nextCategoryId;
    categoryName.value = nextCategoryName;
    brandId.value = nextBrandId;

    await _resolveCategoryNameById();
    await _loadBrands();
    await fetchProducts(reset: true);
  }

  Future<void> _loadBrands() async {
    final cid = categoryId.value;
    if (cid == null || cid.isEmpty) {
      brands.assignAll(BrandModel.mockBrands);
      return;
    }

    isLoadingBrands.value = true;
    try {
      final data = await BrandService.getBrandsByCategory(cid);
      brands.assignAll(data);
    } catch (_) {
      brands.assignAll(BrandModel.mockBrands);
    } finally {
      isLoadingBrands.value = false;
    }
  }

  Future<void> _resolveCategoryNameById() async {
    if (categoryName.value != null && categoryName.value!.trim().isNotEmpty) {
      return;
    }
    final cid = categoryId.value;
    if (cid == null || cid.trim().isEmpty) return;

    final category = await ProductCategoryService.getCategoryById(cid);
    if (category != null && category.name.trim().isNotEmpty) {
      categoryName.value = category.name;
    }
  }

  void onSelectBrand(BrandModel brand) {
    brandId.value = brand.id;
    fetchProducts(reset: true);
  }

  void onSelectFilter(FilterSelection selection) {
    selectedFilter.value = selection.type;
    priceSortState.value = selection.priceSortState;
    fetchProducts(reset: true);
  }

  Future<void> fetchProducts({bool reset = false}) async {
    if (isLoading.value) return;
    if (reset) {
      _requestedSize = _initialPageSize;
      totalElements.value = 0;
      products.clear();
    }

    isLoading.value = true;
    try {
      final sortDirection = _sortDirectionFromFilter(selectedFilter.value);
      final sortBy = priceSortState.value == PriceSortState.none
          ? null
          : 'price';
      final result = await ProductService.searchProduct(
        categoryId: categoryId.value,
        brandId: brandId.value,
        page: 0,
        size: _requestedSize,
        sortBy: sortBy,
        sortDirection: sortDirection,
      );
      totalElements.value = result.totalElements;
      products.assignAll(result.items);
    } catch (_) {
      totalElements.value = ProductModel.mockProducts.length;
      products.assignAll(ProductModel.mockProducts.toList());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLoading.value || isLoadingMore.value || !hasMoreProducts) return;
    isLoadingMore.value = true;
    try {
      _requestedSize += _loadMorePageSize;
      final sortDirection = _sortDirectionFromFilter(selectedFilter.value);
      final sortBy = priceSortState.value == PriceSortState.none
          ? null
          : 'price';
      final result = await ProductService.searchProduct(
        categoryId: categoryId.value,
        brandId: brandId.value,
        page: 0,
        size: _requestedSize,
        sortBy: sortBy,
        sortDirection: sortDirection,
      );
      totalElements.value = result.totalElements;
      products.assignAll(result.items);
    } catch (_) {
      // Keep current list state on load-more failure.
      _requestedSize -= _loadMorePageSize;
    } finally {
      isLoadingMore.value = false;
    }
  }

  String _sortDirectionFromFilter(ProductFilterType filter) {
    if (priceSortState.value == PriceSortState.desc) return 'desc';
    if (priceSortState.value == PriceSortState.asc) return 'asc';
    switch (filter) {
      case ProductFilterType.price:
        return '';
      case ProductFilterType.popular:
      case ProductFilterType.promotion:
      case ProductFilterType.filter:
        return '';
    }
  }
}
