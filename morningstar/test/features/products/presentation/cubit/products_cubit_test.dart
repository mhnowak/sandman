import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morningstar/core/domain/exceptions/unknown_exception.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';
import 'package:morningstar/features/products/presentation/cubit/products_cubit.dart';

import '../../../../t_data.dart';
import '../../products_mock.dart';
import '../../t_products_data.dart';

void main() {
  late MockProductsRepository mockProductsRepository;
  late ProductsCubit cubit;

  setUp(() {
    mockProductsRepository = MockProductsRepository();
  });

  test('Should emit loaded state when request is succesful', () async {
    when(() => mockProductsRepository.products()).thenAnswer((_) async => tProducts);
    cubit = ProductsCubit(mockProductsRepository);

    await pumpEventQueue();

    expect(cubit.state, const DataState.loaded(tProducts));
    verify(() => mockProductsRepository.products()).called(1);
    verifyNoMoreInteractions(mockProductsRepository);
  });

  test('Should emit exception state with [AQException] when request is unsuccesful', () async {
    when(() => mockProductsRepository.products()).thenAnswer((_) async => throw tInvalidResponseDataException);
    cubit = ProductsCubit(mockProductsRepository);

    await pumpEventQueue();

    expect(cubit.state, const DataState<List<ProductModel>>.exception(tInvalidResponseDataException));
    verify(() => mockProductsRepository.products()).called(1);
    verifyNoMoreInteractions(mockProductsRepository);
  });

  test('Should emit exception state with [UnknownException] when something goes wrong', () async {
    when(() => mockProductsRepository.products()).thenAnswer((_) async => throw tUnknownException);
    cubit = ProductsCubit(mockProductsRepository);

    await pumpEventQueue();

    expect(cubit.state, DataState<List<ProductModel>>.exception(UnknownException(tUnknownException)));
    verify(() => mockProductsRepository.products()).called(1);
    verifyNoMoreInteractions(mockProductsRepository);
  });
}
