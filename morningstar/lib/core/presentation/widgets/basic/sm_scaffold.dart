import 'package:flutter/material.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_app_bar.dart';

class SMScaffold extends StatelessWidget {
  const SMScaffold({
    Key? key,
    this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  final Widget? body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SMAppBar(title: title, actions: actions),
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
