import 'package:dio/dio.dart';
import 'package:morningstar/core/domain/exceptions/invalid_response_data_exception.dart';

final tRequestOptions = RequestOptions(path: 'tPath');

const tInvalidResponseDataException = InvalidResponseDataException();

final tUnknownException = Exception();
