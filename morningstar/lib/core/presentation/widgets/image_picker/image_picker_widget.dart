import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        height: 264,
        child: const Icon(
          Icons.add,
          size: 48,
        ),
      ),
    );
  }
}
