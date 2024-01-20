import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/core/presentation/cubit/upload_image_cubit.dart';
import 'package:morningstar/core/presentation/snackbars/error_snackbar.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_scaffold.dart';
import 'package:morningstar/dependencies.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';
import 'package:morningstar/features/products/presentation/cubit/edit_product_cubit.dart';
import 'package:morningstar/features/products/presentation/widgets/product_form_widget.dart';
import 'package:morningstar/generated/l10n.dart';

class UpdateProductPage extends StatefulWidget {
  @visibleForTesting
  const UpdateProductPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  static Route getRoute({required ProductModel product}) => MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<UploadImageCubit>()..setInitialUrl(product.imageUrl),
            ),
            BlocProvider(
              create: (context) => sl<EditProductCubit>(),
            ),
          ],
          child: UpdateProductPage(product: product),
        ),
      );

  @override
  State<UpdateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<UpdateProductPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.title);
    _descriptionController = TextEditingController(text: widget.product.description);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocListener<EditProductCubit, DataState<ProductModel>>(
      listener: (context, state) {
        return switch (state) {
          LoadedState<ProductModel>() => Navigator.pop(context, state.data),
          ExceptionState<ProductModel>() => ErrorSnackbar.show(context, exception: state.exception),
          _ => null,
        };
      },
      child: SMScaffold(
        title: s.updateProductAppBarTitle,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
            onPressed: () => _onUpdate(context),
            child: Text(s.updateProductFloatingButtonTitle),
          ),
        ),
        body: SingleChildScrollView(
          child: ProductFormWidget(
            titleController: _titleController,
            descriptionController: _descriptionController,
            initialUrl: widget.product.imageUrl,
          ),
        ),
      ),
    );
  }

  void _onUpdate(BuildContext context) {
    final uploadImageState = context.read<UploadImageCubit>().state;
    final imageUrl = switch (uploadImageState) { LoadedState<String>() => uploadImageState.data, _ => null };
    if (imageUrl != null && _titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      context.read<EditProductCubit>().editProduct(
            model: ProductModel(
              id: widget.product.id,
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
