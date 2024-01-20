import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morningstar/core/presentation/cubit/upload_image_cubit.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    this.initialUrl,
  });

  final String? initialUrl;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final imgPicker = ImagePicker();
  XFile? _pickedImage;
  String? _pickedUrl;

  @override
  void initState() {
    super.initState();
    _pickedUrl = widget.initialUrl;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onAdd,
      child: _pickedImage != null
          ? Stack(
              alignment: Alignment.topRight,
              children: [
                Image.file(
                  File(_pickedImage!.path),
                  height: 264,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _pickedImage = null;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            )
          : _pickedUrl != null
              ? CachedNetworkImage(
                  imageUrl: _pickedUrl!,
                  height: 264,
                )
              : Container(
                  alignment: Alignment.center,
                  height: 264,
                  child: const Icon(
                    Icons.add,
                    size: 48,
                  ),
                ),
    );
  }

  Future<void> _onAdd() async {
    final cubit = context.read<UploadImageCubit>();
    final result = await imgPicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        _pickedImage = result;
      });
      cubit.uploadFile(result);
    }
  }
}
