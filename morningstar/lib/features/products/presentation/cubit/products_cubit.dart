import 'package:bloc/bloc.dart';
import 'package:morningstar/core/domain/exceptions/sm_exception.dart';
import 'package:morningstar/core/domain/exceptions/unknown_exception.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/features/products/data/products_repository.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';

class ProductsCubit extends Cubit<DataState<List<ProductModel>>> {
  ProductsCubit(this._productsRepository) : super(const DataState.loading()) {
    load();
  }

  final ProductsRepository _productsRepository;

  Future<void> load() async {
    try {
      final result = await _productsRepository.products();
      emit(DataState.loaded(result));
    } on SMException catch (e) {
      emit(DataState.exception(e));
    } catch (e) {
      emit(DataState.exception(UnknownException(e)));
    }
  }
}
