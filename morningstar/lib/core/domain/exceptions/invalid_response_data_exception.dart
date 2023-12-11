import 'package:dio/dio.dart';
import 'package:morningstar/core/domain/exceptions/sm_exception.dart';

/// Thrown when [data] from [Response] doesn't match the expected type.
class InvalidResponseDataException extends SMException {
  const InvalidResponseDataException([this.data]);

  final dynamic data;

  // TODO: Get localized error message.

  @override
  List<Object?> get props => [data];
}
