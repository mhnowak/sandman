import 'package:dio/dio.dart';
import 'package:morningstar/core/data/error_reporter.dart';
import 'package:morningstar/core/domain/exceptions/invalid_response_data_exception.dart';
import 'package:morningstar/core/domain/exceptions/invalid_status_code_exception.dart';

typedef FromJson<T> = T Function(dynamic json);

enum RequestType { get, post, put, delete }

class NetworkManager {
  NetworkManager(
    this._dio, {
    required ErrorReporter errorReporter,
  }) : _errorReporter = errorReporter;

  final Dio _dio;
  final ErrorReporter _errorReporter;

  /// Returns parsed data from GET Request.
  ///
  /// Throws [InvalidResponseDataException] when response data doesn't match return type [R].
  /// Throws [InvalidStatusCodeException] for any unhandable status code.
  Future<R> request<R, T>(
    String path, {
    required FromJson<T> fromJson,
    RequestType type = RequestType.get,
    Map<String, dynamic>? queryParams,
  }) async {
    assert(R == T || R == List<T>, 'Invalid return type [R], return type [R] can only be [List<T>] or T itself.');
    late Response result;
    switch (type) {
      case RequestType.get:
        result = await _dio.get(path, queryParameters: queryParams);
        break;
      case RequestType.post:
        result = await _dio.post(path, queryParameters: queryParams);
        break;
      case RequestType.put:
        result = await _dio.put(path, queryParameters: queryParams);
        break;
      case RequestType.delete:
        result = await _dio.delete(path, queryParameters: queryParams);
        break;
    }

    _handleErrors(result);

    return _handleData<R, T>(result.data, fromJson: fromJson);
  }

  /// Throws [SMException] for any status code, but 200.
  ///
  /// Throws [InvalidStatusCodeException] for any unhandable status code.
  void _handleErrors(Response result) {
    final statusCode = result.statusCode;
    switch (statusCode) {
      case 200:
      // TODO: Handle in tests
      case 204:
      // TODO: Handle in tests
      case 201:
        break;
      default:
        throw InvalidStatusCodeException(result.statusCode, result.statusMessage);
    }
  }

  /// Handles data that matches return type [R].
  ///
  /// Throws [InvalidResponseDataException] when data doesn't match return type [R].
  R _handleData<R, T>(
    dynamic data, {
    required FromJson<T> fromJson,
  }) {
    if (data is Map<String, dynamic>) {
      data = data['data'];
    }

    if (data is List && R == List<T>) {
      return data.map(fromJson).toList(growable: false) as R;
    } else if (data is Map<String, dynamic> && R == T) {
      return fromJson(data) as R;
    }

    // TODO: Handle in tests
    if (data is String && data.isEmpty) {
      return fromJson(data) as R;
    }

    final error = InvalidResponseDataException(data);
    _errorReporter.logError(error);
    throw error;
  }
}
