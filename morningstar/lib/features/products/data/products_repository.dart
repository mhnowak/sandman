import 'package:morningstar/core/data/network_manager.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';

class ProductsRepository {
  ProductsRepository(this._networkManager);

  final NetworkManager _networkManager;

  Future<List<ProductModel>> products() => _networkManager.request<List<ProductModel>, ProductModel>('products',
      fromJson: (json) => ProductModel.fromJson(json));

  Future<ProductModel> createProduct({
    required String title,
    required String description,
    required String imageUrl,
  }) =>
      _networkManager.request(
        'products',
        fromJson: (json) => ProductModel.fromJson(json),
        type: RequestType.post,
        queryParams: {
          'title': title,
          'description': description,
          'image_url': imageUrl,
        },
      );

  Future<ProductModel> updateProduct({
    required int id,
    required String title,
    required String description,
    required String imageUrl,
  }) =>
      _networkManager.request(
        'products/$id',
        fromJson: (json) => ProductModel.fromJson(json),
        type: RequestType.put,
        queryParams: {
          'title': title,
          'description': description,
          'image_url': imageUrl,
        },
      );

  Future<void> deleteProduct(int id) => _networkManager.request<void, void>(
        'products/$id',
        fromJson: (_) => null,
        type: RequestType.delete,
      );
}
