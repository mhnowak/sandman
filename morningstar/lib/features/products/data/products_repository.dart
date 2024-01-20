import 'package:morningstar/core/data/network_manager.dart';
import 'package:morningstar/features/products/domain/models/create_product_model.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';

class ProductsRepository {
  ProductsRepository(this._networkManager);

  final NetworkManager _networkManager;

  Future<List<ProductModel>> products() => _networkManager.request<List<ProductModel>, ProductModel>('products',
      fromJson: (json) => ProductModel.fromJson(json));

  Future<ProductModel> createProduct({
    required CreateProductModel model,
  }) =>
      _networkManager.request(
        'products',
        fromJson: (json) => ProductModel.fromJson(json),
        type: RequestType.post,
        queryParams: {'product': model.toJson()},
      );

  Future<ProductModel> updateProduct({
    required ProductModel model,
  }) =>
      _networkManager.request(
        'products/${model.id}',
        fromJson: (json) => ProductModel.fromJson(json),
        type: RequestType.put,
        queryParams: {'product': model.toJson()},
      );

  Future<void> deleteProduct(int id) => _networkManager.request<void, void>(
        'products/$id',
        fromJson: (_) {},
        type: RequestType.delete,
      );
}
