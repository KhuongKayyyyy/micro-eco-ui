import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/services/secure_storage_service.dart';
import 'package:ecommerce_app/data/dio/dio_interceptor/dio_interceptor.dart';
import 'package:ecommerce_app/data/dio/error/error_exception_type.dart';
import 'package:flutter/foundation.dart';

/// 토큰 타입 (헤더에 넣어줄지를 결정하는 타입)
enum TokenType { none, access, refresh, both }

/// 기본 URL
abstract class BaseURL {
  static const String dev = "http://34.47.125.196:3000/";
  static const String prod = "https://api.studychingu.com/";
  static const String address = "https://provinces.open-api.vn/api/v2";
}

/// 네트워크 서비스
class DioService {
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;

  late final Dio _dio;
  final SecureStorageService _storage = SecureStorageService();

  /// When [baseUrl] is null or blank, requests use [BaseURL.dev].
  String _effectiveBaseUrl(String? baseUrl) {
    final t = baseUrl?.trim() ?? '';
    return t.isEmpty ? BaseURL.dev : t;
  }

  BaseOptions _baseOptionsForRequest(String? baseUrl) {
    return _dio.options.copyWith(baseUrl: _effectiveBaseUrl(baseUrl));
  }

  /// Applies HTTP method, merges token [Options], then [fetch] with a per-request base URL.
  Future<T> _request<T>({
    required String method,
    required String path,
    String? baseUrl,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    TokenType tokenType = TokenType.none,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    final merged = _mergeOptionsWithTokenType(
      options: options,
      tokenType: tokenType,
    );
    final methodOpts = merged ?? Options();
    methodOpts.method = method;

    final requestOptions = methodOpts.compose(
      _baseOptionsForRequest(baseUrl),
      path,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    final response = await _dio.fetch<T>(requestOptions);
    return response.data as T;
  }

  // 생성자 (외부에서 인스턴스를 생성할 수 없음)
  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BaseURL.dev,
        connectTimeout: const Duration(seconds: 45),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        logPrint: (o) => debugPrint(o.toString()),
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );

    // 토큰 인터셉터
    _dio.interceptors.add(DioInterceptor(storage: _storage));
  }

  // GET 요청
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,

    /// Omit or leave empty to use [BaseURL.dev].
    String? baseUrl,
  }) async {
    try {
      return await _request<T>(
        method: 'GET',
        path: path,
        baseUrl: baseUrl,
        queryParameters: parameters,
        options: options,
        tokenType: tokenType,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST 요청
  Future<T> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,

    /// Omit or leave empty to use [BaseURL.dev].
    String? baseUrl,
  }) async {
    try {
      return await _request<T>(
        method: 'POST',
        path: path,
        baseUrl: baseUrl,
        data: data,
        queryParameters: parameters,
        options: options,
        tokenType: tokenType,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT 요청
  Future<T> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,

    /// Omit or leave empty to use [BaseURL.dev].
    String? baseUrl,
  }) async {
    try {
      return await _request<T>(
        method: 'PUT',
        path: path,
        baseUrl: baseUrl,
        data: data,
        queryParameters: parameters,
        options: options,
        tokenType: tokenType,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PATCH 요청
  Future<T> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,

    /// Omit or leave empty to use [BaseURL.dev].
    String? baseUrl,
  }) async {
    try {
      return await _request<T>(
        method: 'PATCH',
        path: path,
        baseUrl: baseUrl,
        data: data,
        queryParameters: parameters,
        options: options,
        tokenType: tokenType,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE 요청
  Future<T> delete<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,

    /// Omit or leave empty to use [BaseURL.dev].
    String? baseUrl,
  }) async {
    try {
      return await _request<T>(
        method: 'DELETE',
        path: path,
        baseUrl: baseUrl,
        data: data,
        queryParameters: parameters,
        options: options,
        tokenType: tokenType,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 파일 다운로드
  Future<void> download({
    required String url,
    required String savePath,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ///
  /// 토큰 타입에 따라 옵션 추가
  ///
  Options? _mergeOptionsWithTokenType({
    Options? options,
    required TokenType tokenType,
  }) {
    // 옵션이 없으면 새로운 옵션 생성
    final extra = Map<String, dynamic>.from(options?.extra ?? {});

    switch (tokenType) {
      case TokenType.access:
        extra['requiresAccessToken'] = true;
        break;
      case TokenType.refresh:
        extra['requiresRefreshToken'] = true;
        break;
      case TokenType.both:
        extra['requiresAccessToken'] = true;
        extra['requiresRefreshToken'] = true;
        break;
      case TokenType.none:
        return options;
    }

    return Options(
      method: options?.method,
      sendTimeout: options?.sendTimeout,
      receiveTimeout: options?.receiveTimeout,
      extra: extra,
      headers: options?.headers,
      responseType: options?.responseType,
      contentType: options?.contentType,
      validateStatus: options?.validateStatus,
      receiveDataWhenStatusError: options?.receiveDataWhenStatusError,
      followRedirects: options?.followRedirects,
      maxRedirects: options?.maxRedirects,
      requestEncoder: options?.requestEncoder,
      responseDecoder: options?.responseDecoder,
    );
  }

  // 에러 핸들링
  Exception _handleError(DioException error) {
    // 토큰 누락 에러 처리
    if (error.error is TokenMissingException) {
      return error.error as TokenMissingException;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('요청이 시간 초과했습니다. (잠시 후 다시 시도해주세요)');

      case DioExceptionType.badResponse: // (200-299) 이외의 상태 코드 반환 시
        // 서버 응답에서 메시지 추출
        String responseMessage = '';

        try {
          final response = error.response?.data;
          if (response is Map<String, dynamic> && response['message'] != null) {
            responseMessage = response['message'].toString();
          }
        } catch (e) {
          responseMessage = '서버 오류가 발생했습니다. (잠시 후 다시 시도해주세요)';
        }

        return ServerException(
          responseMessage,
          statusCode: error.response?.statusCode,
        );
      default:
        return NetworkException('네트워킹 오류가 발생했습니다. (잠시 후 다시 시도해주세요)');
    }
  }
}
