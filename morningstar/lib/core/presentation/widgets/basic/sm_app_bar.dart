import 'package:flutter/material.dart';

class SMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SMAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
    );
  }
}
