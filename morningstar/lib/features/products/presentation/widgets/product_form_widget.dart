import 'package:flutter/material.dart';
import 'package:morningstar/core/presentation/widgets/image_picker/image_picker_widget.dart';
import 'package:morningstar/generated/l10n.dart';

class ProductFormWidget extends StatelessWidget {
  const ProductFormWidget({
    super.key,
    required this.titleController,
    required this.descriptionController,
    this.initialUrl,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String? initialUrl;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          ImagePickerWidget(
            initialUrl: initialUrl,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: titleController,
              validator: (value) => _emptyValidator(s, value),
              decoration: InputDecoration(labelText: s.createProductTitle),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: descriptionController,
              validator: (value) => _emptyValidator(s, value),
              maxLines: 5,
              decoration: InputDecoration(labelText: s.createProductDescription),
            ),
          ),
        ],
      ),
    );
  }

  String? _emptyValidator(S s, String? value) => value?.isEmpty ?? true ? s.genericErrorEmptyField : null;
}
