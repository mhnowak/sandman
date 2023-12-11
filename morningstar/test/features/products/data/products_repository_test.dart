import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morningstar/core/data/network_manager.dart';
import 'package:morningstar/features/products/data/products_repository.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';

import '../../../mock.dart';
import '../t_products_data.dart';

void main() {
  late MockNetworkManager mockNetworkManager;
  late ProductsRepository repository;

  setUp(() {
    mockNetworkManager = MockNetworkManager();
    repository = ProductsRepository(mockNetworkManager);
  });

  test('Products - Should answer with result data when request is successful', () async {
    when(() => mockNetworkManager.request<List<ProductModel>, ProductModel>(
          any(),
          fromJson: any(named: 'fromJson'),
        )).thenAnswer((_) async => tProducts);

    final result = await repository.products();

    expect(result, tProducts);
    verify(() =>
            mockNetworkManager.request<List<ProductModel>, ProductModel>('products', fromJson: any(named: 'fromJson')))
        .called(1);
    verifyNoMoreInteractions(mockNetworkManager);
  });

  test('Create Product - Should answer with result data when request is successful', () async {
    when(() => mockNetworkManager.request<ProductModel, ProductModel>(
          any(),
          fromJson: any(named: 'fromJson'),
          type: RequestType.post,
          queryParams: any(named: 'queryParams'),
        )).thenAnswer((_) async => tProduct1);

    final result = await repository.createProduct(description: 'test', imageUrl: 'test.com', title: 'test');

    expect(result, tProduct1);
    verify(() => mockNetworkManager.request<ProductModel, ProductModel>(
          'products',
          fromJson: any(named: 'fromJson'),
          type: RequestType.post,
          queryParams: any(named: 'queryParams'),
        )).called(1);
    verifyNoMoreInteractions(mockNetworkManager);
  });

  test('Edit Product - Should answer with result data when request is successful', () async {
    when(() => mockNetworkManager.request<ProductModel, ProductModel>(
          any(),
          fromJson: any(named: 'fromJson'),
          type: RequestType.put,
          queryParams: any(named: 'queryParams'),
        )).thenAnswer((_) async => tProduct1);

    final result = await repository.updateProduct(id: 1, description: 'test', imageUrl: 'test.com', title: 'test');

    expect(result, tProduct1);
    verify(() => mockNetworkManager.request<ProductModel, ProductModel>(
          'products/1',
          fromJson: any(named: 'fromJson'),
          type: RequestType.put,
          queryParams: any(named: 'queryParams'),
        )).called(1);
    verifyNoMoreInteractions(mockNetworkManager);
  });

  test('Delete Product - Should answer with result data when request is successful', () async {
    when(() => mockNetworkManager.request<void, void>(
          any(),
          fromJson: any(named: 'fromJson'),
          type: RequestType.delete,
          queryParams: any(named: 'queryParams'),
        )).thenAnswer((_) async {});

    await repository.deleteProduct(1);

    verify(() => mockNetworkManager.request<void, void>(
          'products/1',
          fromJson: any(named: 'fromJson'),
          type: RequestType.delete,
          queryParams: any(named: 'queryParams'),
        )).called(1);
    verifyNoMoreInteractions(mockNetworkManager);
  });
}
