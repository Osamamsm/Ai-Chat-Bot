import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  final String _baseUrl;

  ApiClient({String? baseUrl, Dio? dio})
    : _baseUrl = baseUrl ?? '',
      _dio = dio ?? Dio() {
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final url = _baseUrl.isEmpty ? path : '$_baseUrl$path';
    return await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
