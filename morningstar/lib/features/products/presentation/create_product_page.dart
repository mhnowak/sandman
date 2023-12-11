import 'package:flutter/material.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_scaffold.dart';
import 'package:morningstar/core/presentation/widgets/image_picker/image_picker_widget.dart';
import 'package:morningstar/generated/l10n.dart';

class CreateProductPage extends StatefulWidget {
  @visibleForTesting
  const CreateProductPage({super.key});

  static Route getRoute() => MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const CreateProductPage(),
      );

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SMScaffold(
      title: s.createProductAppBarTitle,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: TextButton(
          onPressed: () {},
          child: Text(s.createProductFloatingButtonTitle),
        ),
      ),
      body: SingleChildScrollView(
        child: _formWidget(s),
      ),
    );
  }

  Widget _formWidget(S s) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const ImagePickerWidget(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _titleController,
              validator: (value) => _emptyValidator(s, value),
              decoration: InputDecoration(labelText: s.createProductTitle),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _descriptionController,
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
