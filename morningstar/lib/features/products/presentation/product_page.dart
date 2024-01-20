import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/core/presentation/snackbars/error_snackbar.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_network_image.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_scaffold.dart';
import 'package:morningstar/dependencies.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';
import 'package:morningstar/features/products/presentation/cubit/delete_product_cubit.dart';
import 'package:morningstar/features/products/presentation/update_product_page.dart';
import 'package:morningstar/generated/l10n.dart';

class ProductPage extends StatefulWidget {
  @visibleForTesting
  const ProductPage({
    super.key,
    required this.product,
    required this.refresh,
  });

  static Route getRoute({
    required ProductModel product,
    required VoidCallback refresh,
  }) =>
      MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => sl<DeleteProductCubit>(),
                child: ProductPage(
                  product: product,
                  refresh: refresh,
                ),
              ));

  final ProductModel product;
  final VoidCallback refresh;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductModel _product;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    return SMScaffold(
      title: s.productAppBarTitle,
      actions: [
        BlocConsumer<DeleteProductCubit, DataState<void>>(
          listener: (context, state) {
            if (state case LoadedState<void>()) {
              Navigator.pop(context, true);
            } else if (state case ExceptionState<void>()) {
              ErrorSnackbar.show(context, exception: state.exception);
            }
          },
          builder: (context, state) {
            if (state case LoadingState<void>()) {
              return const CircularProgressIndicator();
            }

            return IconButton(
              onPressed: () => _onMorePressed(context),
              icon: const Icon(Icons.more_vert),
            );
          },
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SMNetworkImage(
              imageUrl: _product.imageUrl,
              height: 314,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _product.title,
                style: textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _product.description,
                style: textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMorePressed(BuildContext context) {
    final s = S.of(context);
    final deleteCubit = context.read<DeleteProductCubit>();
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) => BottomSheet(
        onClosing: () {},
        constraints: const BoxConstraints(maxHeight: 156),
        builder: (context) => Column(
          children: [
            const SizedBox(height: 24),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    title: Text(s.productDeleteDialogTitle),
                    actions: [
                      _adaptiveAction(
                        context: context,
                        onPressed: () {
                          deleteCubit.delete(id: _product.id);
                          Navigator.pop(context);
                        },
                        child: Text(s.productDeleteDialogConfirm),
                        isDestructiveAction: true,
                      ),
                      _adaptiveAction(
                        context: context,
                        onPressed: () => Navigator.pop(context),
                        child: Text(s.productDeleteDialogCancel),
                        isDefaultAction: true,
                      ),
                    ],
                  ),
                );
              },
              leading: const Icon(Icons.delete),
              title: Text(s.productActionDelete),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(context, UpdateProductPage.getRoute(product: _product));
                if (result is ProductModel) {
                  widget.refresh();
                  setState(() {
                    _product = result;
                  });
                }
              },
              leading: const Icon(Icons.edit),
              title: Text(s.productActionEdit),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adaptiveAction({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
    bool isDestructiveAction = false,
    bool isDefaultAction = false,
  }) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(
          onPressed: onPressed,
          child: child,
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(
          onPressed: onPressed,
          isDestructiveAction: isDestructiveAction,
          isDefaultAction: isDefaultAction,
          child: child,
        );
    }
  }
}
