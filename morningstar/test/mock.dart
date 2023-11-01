import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:morningstar/core/data/error_reporter.dart';
import 'package:morningstar/core/data/network_manager.dart';

class MockDio extends Mock implements Dio {}

class MockErrorReporter extends Mock implements ErrorReporter {}

class MockNetworkManager extends Mock implements NetworkManager {}
