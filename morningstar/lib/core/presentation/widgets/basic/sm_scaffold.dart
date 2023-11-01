import 'package:flutter/material.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_app_bar.dart';

class SMScaffold extends StatelessWidget {
  const SMScaffold({
    Key? key,
    this.body,
    this.title,
  }) : super(key: key);

  final Widget? body;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SMAppBar(title: title),
      body: body,
    );
  }
}
