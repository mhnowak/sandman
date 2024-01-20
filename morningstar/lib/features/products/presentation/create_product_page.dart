import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/core/presentation/cubit/upload_image_cubit.dart';
import 'package:morningstar/core/presentation/snackbars/error_snackbar.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_scaffold.dart';
import 'package:morningstar/dependencies.dart';
import 'package:morningstar/features/products/domain/models/create_product_model.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';
import 'package:morningstar/features/products/presentation/cubit/create_product_cubit.dart';
import 'package:morningstar/features/products/presentation/widgets/product_form_widget.dart';
import 'package:morningstar/generated/l10n.dart';

class CreateProductPage extends StatefulWidget {
  @visibleForTesting
  const CreateProductPage({super.key});

  static Route getRoute() => MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<UploadImageCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<CreateProductCubit>(),
            ),
          ],
          child: const CreateProductPage(),
        ),
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

    return BlocListener<CreateProductCubit, DataState<ProductModel>>(
      listener: (context, state) {
        return switch (state) {
          LoadedState<ProductModel>() => Navigator.pop(context, state.data),
          ExceptionState<ProductModel>() => ErrorSnackbar.show(context, exception: state.exception),
          _ => null,
        };
      },
      child: SMScaffold(
        title: s.createProductAppBarTitle,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
            onPressed: () => _onCreate(context),
            child: Text(s.createProductFloatingButtonTitle),
          ),
        ),
        body: SingleChildScrollView(
          child: ProductFormWidget(
            titleController: _titleController,
            descriptionController: _descriptionController,
          ),
        ),
      ),
    );
  }

  void _onCreate(BuildContext context) {
    final uploadImageState = context.read<UploadImageCubit>().state;
    final imageUrl = switch (uploadImageState) { LoadedState<String>() => uploadImageState.data, _ => null };
    if (imageUrl != null && _titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      context.read<CreateProductCubit>().createProduct(
            model: CreateProductModel(
              title: _titleController.text,
              description: _descriptionController.text,
              imageUrl: imageUrl,
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).createProductInvalidRequestErrorMessage),
        ),
      );
    }
  }
}
