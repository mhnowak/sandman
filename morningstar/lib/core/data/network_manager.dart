import 'package:dio/dio.dart';
import 'package:morningstar/core/data/error_reporter.dart';
import 'package:morningstar/core/domain/exceptions/invalid_response_data_exception.dart';
import 'package:morningstar/core/domain/exceptions/invalid_status_code_exception.dart';

typedef FromJson<T> = T Function(dynamic json);

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
  Future<R> get<R, T>(
    String path, {
    required FromJson<T> fromJson,
  }) async {
    assert(R == T || R == List<T>, 'Invalid return type [R], return type [R] can only be [List<T>] or T itself.');
    final result = await _dio.get(path);

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
    if (data is List && R == List<T>) {
      return data.map(fromJson).toList(growable: false) as R;
    } else if (data is Map<String, dynamic> && R == T) {
      return fromJson(data) as R;
    }

    final error = InvalidResponseDataException(data);
    _errorReporter.logError(error);
    throw error;
  }
}
