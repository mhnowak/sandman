import 'package:flutter/material.dart';

class SMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SMAppBar({
    Key? key,
    this.title,
    this.actions,
  }) : super(key: key);

  final String? title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      actions: actions,
    );
  }
}
