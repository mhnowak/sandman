import 'package:morningstar/core/domain/exceptions/sm_exception.dart';

class InvalidStatusCodeException extends SMException {
  const InvalidStatusCodeException(this.statusCode, this.statusMessage);

  final int? statusCode;
  final String? statusMessage;

  @override
  List<Object?> get props => [statusCode, statusMessage];
}
