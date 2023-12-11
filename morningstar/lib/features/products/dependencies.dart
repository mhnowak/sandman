import 'package:morningstar/dependencies.dart';
import 'package:morningstar/features/products/data/products_repository.dart';
import 'package:morningstar/features/products/presentation/cubit/delete_product_cubit.dart';
import 'package:morningstar/features/products/presentation/cubit/edit_product_cubit.dart';
import 'package:morningstar/features/products/presentation/cubit/products_cubit.dart';

void setup() {
  sl
    ..registerLazySingleton(() => ProductsRepository(sl()))
    ..registerFactory(() => DeleteProductCubit(sl()))
    ..registerFactory(() => EditProductCubit(sl()))
    ..registerFactory(() => ProductsCubit(sl()));
}
