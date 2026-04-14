import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static const String _defaultProductServiceBaseUrl = 'http://localhost:8080/';

  /// Product-category microservice base URL from `.env`.
  /// Fallback: [ _defaultProductServiceBaseUrl ].
  static String get productServiceBaseUrl {
    final raw = dotenv.env['PRODUCT_SERVICE_BASE_URL']?.trim();
    if (raw == null || raw.isEmpty) return _defaultProductServiceBaseUrl;
    return raw.endsWith('/') ? raw : '$raw/';
  }
}
