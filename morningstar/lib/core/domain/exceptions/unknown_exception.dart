import 'package:morningstar/core/domain/exceptions/sm_exception.dart';

class UnknownException extends SMException {
  const UnknownException([this.exception]);

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
