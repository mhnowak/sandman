import 'package:bloc/bloc.dart';
import 'package:morningstar/core/domain/exceptions/sm_exception.dart';
import 'package:morningstar/core/domain/exceptions/unknown_exception.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/features/products/data/products_repository.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';

class EditProductCubit extends Cubit<DataState<ProductModel>> {
  EditProductCubit(this._productsRepository) : super(const DataState.idle());

  final ProductsRepository _productsRepository;

  Future<void> editProduct({
    required ProductModel model,
  }) async {
    emit(const DataState.loading());
    try {
      final result = await _productsRepository.updateProduct(model: model);

      emit(DataState.loaded(result));
    } on SMException catch (e) {
      emit(DataState.exception(e));
    } catch (e) {
      emit(DataState.exception(UnknownException(e)));
    }
  }
}
