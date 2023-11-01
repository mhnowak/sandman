import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morningstar/core/data/network_manager.dart';
import 'package:morningstar/core/domain/exceptions/invalid_response_data_exception.dart';
import 'package:morningstar/core/domain/exceptions/invalid_status_code_exception.dart';

import '../../mock.dart';
import '../../t_data.dart';

void main() {
  const tData = 'tData';
  const tPath = 'tPath';
  String tFromJson(_) => tData;
  const tStatusCode404 = 404;
  const tMessageNotFound = 'Not Found';

  late MockDio mockDio;
  late MockErrorReporter mockErroReporter;
  late NetworkManager networkManager;

  setUp(() {
    mockDio = MockDio();
    mockErroReporter = MockErrorReporter();
    networkManager = NetworkManager(mockDio, errorReporter: mockErroReporter);

    // when(() => mockErroReporter.logError(any(), any())).thenReturn(null);
  });

  group('GET - ', () {
    test('When call is successful, data is json and matches with return type then returns parsed data', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
            data: {'data': tData},
            requestOptions: tRequestOptions,
            statusCode: 200,
          ));

      final result = await networkManager.get<String, String>(tPath, fromJson: tFromJson);

      expect(result, tData);
      verify(() => mockDio.get(tPath)).called(1);
      verifyNoMoreInteractions(mockDio);
      verifyZeroInteractions(mockErroReporter);
    });

    test('When call is successful, data is list and matches with return type then returns parsed data', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
            data: [
              {'data': tData}
            ],
            requestOptions: tRequestOptions,
            statusCode: 200,
          ));

      final result = await networkManager.get<List<String>, String>(tPath, fromJson: tFromJson);

      expect(result, [tData]);
      verify(() => mockDio.get(tPath)).called(1);
      verifyNoMoreInteractions(mockDio);
      verifyZeroInteractions(mockErroReporter);
    });

    test('When the response is successful, data is null so it doesnt match return type then throws', () async {
      const tError = InvalidResponseDataException(null);
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
            data: null,
            requestOptions: tRequestOptions,
            statusCode: 200,
          ));

      final result = networkManager.get<String, String>(tPath, fromJson: tFromJson);

      expect(result, throwsA(tError));
      await pumpEventQueue();
      verify(() => mockDio.get(tPath)).called(1);
      verify(() => mockErroReporter.logError(tError, any())).called(1);
      verifyNoMoreInteractions(mockDio);
      verifyNoMoreInteractions(mockErroReporter);
    });

    test('When the response is unsuccessful and status code is 404 then throws', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
            data: null,
            requestOptions: tRequestOptions,
            statusCode: tStatusCode404,
            statusMessage: tMessageNotFound,
          ));

      final result = networkManager.get<String, String>(tPath, fromJson: tFromJson);

      expect(result, throwsA(const InvalidStatusCodeException(tStatusCode404, tMessageNotFound)));
      verify(() => mockDio.get(tPath)).called(1);
      verifyNoMoreInteractions(mockDio);
      verifyZeroInteractions(mockErroReporter);
    });

    test('When the response is unsuccessful and status code is null then throws', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
            data: null,
            requestOptions: tRequestOptions,
            statusCode: null,
            statusMessage: null,
          ));

      final result = networkManager.get<String, String>(tPath, fromJson: tFromJson);

      expect(result, throwsA(const InvalidStatusCodeException(null, null)));
      verify(() => mockDio.get(tPath)).called(1);
      verifyNoMoreInteractions(mockDio);
      verifyZeroInteractions(mockErroReporter);
    });
  });
}
