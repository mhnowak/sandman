import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:morningstar/core/presentation/theme/theme.dart';
import 'package:morningstar/features/products/presentation/products_page.dart';
import 'package:morningstar/generated/l10n.dart';

class SMApp extends StatelessWidget {
  const SMApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const ProductsPage(),
    );
  }
}
