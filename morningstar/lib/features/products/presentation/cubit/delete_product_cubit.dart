import 'package:bloc/bloc.dart';
import 'package:morningstar/core/domain/exceptions/sm_exception.dart';
import 'package:morningstar/core/domain/exceptions/unknown_exception.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/features/products/data/products_repository.dart';

class DeleteProductCubit extends Cubit<DataState<void>> {
  DeleteProductCubit(this._productsRepository) : super(const DataState.idle());

  final ProductsRepository _productsRepository;

  Future<void> delete({required int id}) async {
    emit(const DataState.loading());
    try {
      await _productsRepository.deleteProduct(id);

      emit(const DataState.loaded(null));
    } on SMException catch (e) {
      emit(DataState.exception(e));
    } catch (e) {
      emit(DataState.exception(UnknownException(e)));
    }
  }
}
