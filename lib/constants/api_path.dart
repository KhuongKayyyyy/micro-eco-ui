class ApiPath {
  //user - access
  static const String accessByRefresh = 'user/access-by-refresh';
  static const String refreshByRefresh = 'user/refresh-by-refresh';

  //address (provinces.open-api.vn)
  static const String getAllProvinces = '/p';

  /// Use with `?depth=2` to load nested [wards] for that province.
  static String provinceByCode(int code) => '/p/$code';
}
