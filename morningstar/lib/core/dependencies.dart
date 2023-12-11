import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/foundation.dart';
import 'package:morningstar/core/data/error_reporter.dart';
import 'package:morningstar/core/data/network_manager.dart';
import 'package:morningstar/core/data/upload_images_service.dart';
import 'package:morningstar/dependencies.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const kBaseUrl = 'http://localhost:4000/api/';

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
    ..registerLazySingleton(() => Cloudinary.unsignedConfig(cloudName: 'dddserrbs'))
    ..registerLazySingleton(() => UploadImagesService(cloudinary: sl()))
    ..registerLazySingleton(
      () => NetworkManager(
        sl(),
        errorReporter: sl(),
      ),
    );
}
