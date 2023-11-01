import 'package:equatable/equatable.dart';
import 'package:morningstar/core/domain/exceptions/sm_exception.dart';

sealed class DataState<T> extends Equatable {
  const DataState();

  const factory DataState.loading() = LoadingState;
  const factory DataState.loaded(T data) = LoadedState<T>;
  const factory DataState.exception(SMException e) = ExceptionState;

  @override
  List<Object?> get props => [];
}

class LoadingState<T> extends DataState<T> {
  const LoadingState();
}

class LoadedState<T> extends DataState<T> {
  const LoadedState(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

class ExceptionState<T> extends DataState<T> {
  const ExceptionState(this.exception);

  final SMException exception;

  @override
  List<Object?> get props => [exception];
}
