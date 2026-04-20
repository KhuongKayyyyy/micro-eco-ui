import 'package:ecommerce_app/common/services/navigation_payload_store.dart';
import 'package:ecommerce_app/common/utils/app_navigator_utils.dart';
import 'package:ecommerce_app/constants/app_routes.dart';
import 'package:ecommerce_app/data/service/article_service.dart';
import 'package:ecommerce_app/data/service/brand_service.dart';
import 'package:ecommerce_app/data/service/product_category_service.dart';
import 'package:ecommerce_app/data/service/product_service.dart';
import 'package:ecommerce_app/model/article/article_model.dart';
import 'package:ecommerce_app/model/brand/brand_model.dart';
import 'package:ecommerce_app/model/product/product_model.dart';
import 'package:ecommerce_app/screens/product/components/filter_list.dart';

import 'package:ecommerce_app/screens/product/product_list/components/filter_pop_up.dart';
import 'package:ecommerce_app/screens/product/product_list/components/price_filter_pop_up.dart';
import 'package:get/get.dart';
import 'package:decimal/decimal.dart';

class ProductListPageController extends GetxController {
  static const int _initialPageSize = 10;
  static const int _loadMorePageSize = 20;

  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final products = <ProductModel>[].obs;
  final articles = <ArticleModel>[].obs;
  final brands = BrandModel.mockBrands.toList().obs;
  final isLoadingBrands = false.obs;
  final isLoadingArticles = false.obs;
  final categoryId = RxnString();
  final categoryName = RxnString();
  final brandId = RxnString();
  final selectedFilter = ProductFilterType.popular.obs;
  final priceSortState = PriceSortState.none.obs;
  final minPrice = Rxn<Decimal>();
  final maxPrice = Rxn<Decimal>();
  final availableOnly = false.obs;

  /// Multi-value filters (each list is joined with ", " in the request).
  final appliedAttributes = <String, List<String>>{}.obs;
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

  bool get hasAttributeFilters =>
      appliedAttributes.entries.any((e) => e.value.isNotEmpty);

  bool get showFilterBarBadge =>
      (minPrice.value != null && maxPrice.value != null) ||
      availableOnly.value ||
      hasAttributeFilters;

  Map<String, List<String>> get appliedAttributesSnapshot =>
      appliedAttributes.map((k, v) => MapEntry(k, List<String>.from(v)));

  Map<String, String> get _attributeQueryParams => {
    for (final e in appliedAttributes.entries)
      if (e.value.isNotEmpty) e.key: e.value.join(', '),
  };

  int _requestedSize = _initialPageSize;

  @override
  void onInit() {
    super.onInit();
    _applyRouteParameters(_currentRouteParameters);
    _resolveCategoryNameById();
    _loadBrands();
    _loadArticles();
    fetchProducts();
  }

  @override
  void onReady() {
    super.onReady();

    // Apply lần đầu
    applyRouteParameters(_currentRouteParameters);

    // Lắng nghe khi route thay đổi
    ever(Get.routing.obs, (_) {
      applyRouteParameters(_currentRouteParameters);
    });
  }

  String? _normalizeNullable(dynamic raw) {
    if (raw == null) return null;
    final value = raw.toString().trim();
    if (value.isEmpty || value.toLowerCase() == 'null') return null;
    return value;
  }

  Map<String, String> get _currentRouteParameters {
    final parameters = <String, String>{};
    if (Get.parameters.isNotEmpty) {
      Get.parameters.forEach((key, value) {
        if (value == null) return;
        parameters[key] = value;
      });
    }

    // Fallback for nested navigator cases where Get.parameters is empty
    // but the current route name still contains query parameters.
    final rawRouteName = Get.rawRoute?.settings.name;
    final uri = rawRouteName == null ? null : Uri.tryParse(rawRouteName);
    if (uri != null && uri.queryParameters.isNotEmpty) {
      parameters.addAll(uri.queryParameters);
    }

    if (parameters.isEmpty) {
      final payloadStore = Get.find<NavigationPayloadStore>();
      parameters.addAll(payloadStore.consume(AppRoutes.productList));
    }
    return parameters;
  }

  void _applyRouteParameters(Map<String, String> parameters) {
    if (parameters.containsKey('categoryId')) {
      categoryId.value = _normalizeNullable(parameters['categoryId']);
    }
    if (parameters.containsKey('categoryName')) {
      categoryName.value = _normalizeNullable(parameters['categoryName']);
    }
    if (parameters.containsKey('brandId')) {
      brandId.value = _normalizeNullable(parameters['brandId']);
    }
  }

  Future<void> applyRouteParameters(Map<String, String> parameters) async {
    if (parameters.isEmpty) return;
    if (!parameters.containsKey('categoryId') &&
        !parameters.containsKey('categoryName') &&
        !parameters.containsKey('brandId')) {
      return;
    }

    final nextCategoryId = parameters.containsKey('categoryId')
        ? _normalizeNullable(parameters['categoryId'])
        : categoryId.value;
    final nextCategoryName = parameters.containsKey('categoryName')
        ? _normalizeNullable(parameters['categoryName'])
        : categoryName.value;
    final nextBrandId = parameters.containsKey('brandId')
        ? _normalizeNullable(parameters['brandId'])
        : brandId.value;

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
    await _loadArticles();
    await fetchProducts(reset: true);
  }

  Future<void> _loadArticles() async {
    final cid = categoryId.value;
    if (cid == null || cid.trim().isEmpty) {
      articles.clear();
      return;
    }

    isLoadingArticles.value = true;
    try {
      final data = await ArticleService.getArticlesByCategory(cid);
      articles.assignAll(data);
    } catch (_) {
      articles.clear();
    } finally {
      isLoadingArticles.value = false;
    }
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

  /// Selects the "Bộ lọc" tab visually without refetching (sheet will apply).
  void selectFilterTabOnly() {
    selectedFilter.value = ProductFilterType.filter;
  }

  void applyFilterSheet(FilterSheetApply apply) {
    minPrice.value = apply.priceRange.minPrice;
    maxPrice.value = apply.priceRange.maxPrice;
    availableOnly.value = apply.availableOnly;
    appliedAttributes.assignAll(
      apply.attributes.map((k, v) => MapEntry(k, List<String>.from(v))),
    );
    fetchProducts(reset: true);
  }

  void toggleAvailableOnly() {
    availableOnly.value = !availableOnly.value;
    fetchProducts(reset: true);
  }

  void applyPriceRange(PriceRange range, PriceSortState sortState) {
    // "By price" in criteria_list only sets min/max range.
    // It should not force switching FilterList to "Price" (sort).
    priceSortState.value = sortState;
    minPrice.value = range.minPrice;
    maxPrice.value = range.maxPrice;
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
        minPrice: minPrice.value,
        maxPrice: maxPrice.value,
        available: availableOnly.value ? true : null,
        page: 0,
        size: _requestedSize,
        sortBy: sortBy,
        sortDirection: sortDirection,
        attributeQuery: _attributeQueryParams.isEmpty
            ? null
            : _attributeQueryParams,
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
        minPrice: minPrice.value,
        maxPrice: maxPrice.value,
        available: availableOnly.value ? true : null,
        page: 0,
        size: _requestedSize,
        sortBy: sortBy,
        sortDirection: sortDirection,
        attributeQuery: _attributeQueryParams.isEmpty
            ? null
            : _attributeQueryParams,
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

  void goToProductDetail(String productId) {
    Get.toNamed(AppRoutes.productDetail, parameters: {'productId': productId});
  }
}
