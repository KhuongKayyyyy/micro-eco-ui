class ApiPath {
  //user - access
  static const String accessByRefresh = 'user/access-by-refresh';
  static const String refreshByRefresh = 'user/refresh-by-refresh';

  //address (provinces.open-api.vn)
  static const String getAllProvinces = '/p';

  /// Use with `?depth=2` to load nested [wards] for that province.
  static String provinceByCode(int code) => '/p/$code';

  /// product categories
  static const String productCategories = 'product-categories';
  static const String rootProductCategories = 'product-categories/rootCategory';
  static const String productCategoryById = 'product-categories/{id}';

  /// brands
  static const String brands = 'brands';
  static const String brandById = 'brands/{id}';
  static const String brandByCategory = 'brand/by-category/{category}';

  /// products
  static const String productSearch = 'products/search';
}
