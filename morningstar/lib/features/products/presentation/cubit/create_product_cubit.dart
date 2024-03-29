import 'package:bloc/bloc.dart';
import 'package:morningstar/core/domain/exceptions/sm_exception.dart';
import 'package:morningstar/core/domain/exceptions/unknown_exception.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/features/products/data/products_repository.dart';
import 'package:morningstar/features/products/domain/models/create_product_model.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';

class CreateProductCubit extends Cubit<DataState<ProductModel>> {
  CreateProductCubit(this._productsRepository) : super(const DataState.idle());

  final ProductsRepository _productsRepository;

  Future<void> createProduct({
    required CreateProductModel model,
  }) async {
    emit(const DataState.loading());
    try {
      final result = await _productsRepository.createProduct(model: model);

      emit(DataState.loaded(result));
    } on SMException catch (e) {
      emit(DataState.exception(e));
    } catch (e) {
      emit(DataState.exception(UnknownException(e)));
    }
  }
}
