// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sandman`
  String get productsAppBarTitle {
    return Intl.message(
      'Sandman',
      name: 'productsAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sandman`
  String get productAppBarTitle {
    return Intl.message(
      'Sandman',
      name: 'productAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get productActionDelete {
    return Intl.message(
      'Delete',
      name: 'productActionDelete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get productActionEdit {
    return Intl.message(
      'Edit',
      name: 'productActionEdit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this product?`
  String get productDeleteDialogTitle {
    return Intl.message(
      'Are you sure you want to delete this product?',
      name: 'productDeleteDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get productDeleteDialogConfirm {
    return Intl.message(
      'Confirm',
      name: 'productDeleteDialogConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get productDeleteDialogCancel {
    return Intl.message(
      'Cancel',
      name: 'productDeleteDialogCancel',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.. Please try again later.`
  String get genericErrorMessage {
    return Intl.message(
      'Something went wrong.. Please try again later.',
      name: 'genericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Field cannot be empty`
  String get genericErrorEmptyField {
    return Intl.message(
      'Field cannot be empty',
      name: 'genericErrorEmptyField',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get createProductAppBarTitle {
    return Intl.message(
      'Add product',
      name: 'createProductAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update product`
  String get updateProductAppBarTitle {
    return Intl.message(
      'Update product',
      name: 'updateProductAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get createProductTitle {
    return Intl.message(
      'Title',
      name: 'createProductTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get createProductFloatingButtonTitle {
    return Intl.message(
      'Add',
      name: 'createProductFloatingButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get updateProductFloatingButtonTitle {
    return Intl.message(
      'Update',
      name: 'updateProductFloatingButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Title, description and image cannot be empty`
  String get createProductInvalidRequestErrorMessage {
    return Intl.message(
      'Title, description and image cannot be empty',
      name: 'createProductInvalidRequestErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Response Data Exception`
  String get exceptionInvalidResponseData {
    return Intl.message(
      'Invalid Response Data Exception',
      name: 'exceptionInvalidResponseData',
      desc: '',
      args: [],
    );
  }

  /// `Invalid status code {code}`
  String exceptionInvalidStatusCode(Object code) {
    return Intl.message(
      'Invalid status code $code',
      name: 'exceptionInvalidStatusCode',
      desc: '',
      args: [code],
    );
  }

  /// `Unknown exception`
  String get exceptionUnknown {
    return Intl.message(
      'Unknown exception',
      name: 'exceptionUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get createProductDescription {
    return Intl.message(
      'Description',
      name: 'createProductDescription',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
