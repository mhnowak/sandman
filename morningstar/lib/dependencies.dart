import 'package:get_it/get_it.dart';
import 'package:morningstar/core/dependencies.dart' as core;
import 'package:morningstar/features/products/dependencies.dart' as products;

final sl = GetIt.instance;

void setup() {
  core.setup();
  products.setup();
}
