import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:morningstar/core/data/error_reporter.dart';
import 'package:morningstar/core/data/network_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const kBaseUrl = 'http://localhost:4000/api/';

final sl = GetIt.instance;

void setup() {
  sl
    ..registerLazySingleton(() {
      final dio = Dio(BaseOptions(baseUrl: kBaseUrl));
      if (kDebugMode) {
        dio.interceptors.add(PrettyDioLogger());
      }
      return dio;
    })
    ..registerLazySingleton(() => ErrorReporter())
    ..registerLazySingleton(
      () => NetworkManager(
        sl(),
        errorReporter: sl(),
      ),
    );
}
