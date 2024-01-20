import 'package:flutter/material.dart';
import 'package:morningstar/core/domain/exceptions/invalid_response_data_exception.dart';
import 'package:morningstar/core/domain/exceptions/invalid_status_code_exception.dart';
import 'package:morningstar/core/domain/exceptions/sm_exception.dart';
import 'package:morningstar/core/domain/exceptions/unknown_exception.dart';
import 'package:morningstar/generated/l10n.dart';

class ErrorSnackbar {
  static show(
    BuildContext context, {
    required SMException exception,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(getExceptionMessage(context, exception: exception)),
      ),
    );
  }

  static String getExceptionMessage(
    BuildContext context, {
    required SMException exception,
  }) {
    final s = S.of(context);
    if (exception is InvalidResponseDataException) {
      return s.exceptionInvalidResponseData;
    } else if (exception is InvalidStatusCodeException) {
      return s.exceptionInvalidStatusCode(exception.statusCode ?? 'Unknown code');
    } else if (exception is UnknownException) {
      return s.exceptionUnknown;
    } else {
      return s.genericErrorMessage;
    }
  }
}
