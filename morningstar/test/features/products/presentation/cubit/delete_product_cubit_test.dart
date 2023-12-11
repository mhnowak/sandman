import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morningstar/core/domain/exceptions/unknown_exception.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/features/products/presentation/cubit/delete_product_cubit.dart';

import '../../../../t_data.dart';
import '../../products_mock.dart';

void main() {
  const tId = 1;
  late MockProductsRepository mockProductsRepository;
  late DeleteProductCubit cubit;

  setUp(() {
    mockProductsRepository = MockProductsRepository();
    cubit = DeleteProductCubit(mockProductsRepository);
  });

  test('Should emit loaded state when request is succesful', () async {
    when(() => mockProductsRepository.deleteProduct(any())).thenAnswer((_) async {});

    await cubit.delete(id: tId);

    expect(cubit.state, const DataState<void>.loaded(null));
    verify(() => mockProductsRepository.deleteProduct(tId)).called(1);
    verifyNoMoreInteractions(mockProductsRepository);
  });

  test('Should emit exception state with [AQException] when request is unsuccesful', () async {
    when(() => mockProductsRepository.deleteProduct(any()))
        .thenAnswer((_) async => throw tInvalidResponseDataException);

    await cubit.delete(id: tId);

    expect(cubit.state, const DataState<void>.exception(tInvalidResponseDataException));
    verify(() => mockProductsRepository.deleteProduct(tId)).called(1);
    verifyNoMoreInteractions(mockProductsRepository);
  });

  test('Should emit exception state with [UnknownException] when something goes wrong', () async {
    when(() => mockProductsRepository.deleteProduct(any())).thenAnswer((_) async => throw tUnknownException);

    await cubit.delete(id: tId);

    expect(cubit.state, DataState<void>.exception(UnknownException(tUnknownException)));
    verify(() => mockProductsRepository.deleteProduct(tId)).called(1);
    verifyNoMoreInteractions(mockProductsRepository);
  });
}
