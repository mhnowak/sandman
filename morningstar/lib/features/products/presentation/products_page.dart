import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morningstar/core/domain/state/data_state.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_network_image.dart';
import 'package:morningstar/core/presentation/widgets/basic/sm_scaffold.dart';
import 'package:morningstar/dependencies.dart';
import 'package:morningstar/features/products/domain/models/product_model.dart';
import 'package:morningstar/features/products/presentation/create_product_page.dart';
import 'package:morningstar/features/products/presentation/cubit/products_cubit.dart';
import 'package:morningstar/features/products/presentation/product_page.dart';
import 'package:morningstar/generated/l10n.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocProvider(
      create: (_) => sl<ProductsCubit>(),
      child: SMScaffold(
        title: s.productsAppBarTitle,
        floatingActionButton: IconButton(
          onPressed: () => Navigator.push(context, CreateProductPage.getRoute()),
          icon: const Icon(Icons.add),
        ),
        body: const _ProductsView(),
      ),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductsCubit>().state;

    switch (state) {
      case IdleState<List<ProductModel>>():
      case LoadingState<List<ProductModel>>():
        return const Center(child: CircularProgressIndicator());
      case LoadedState<List<ProductModel>>():
        final products = state.data;

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return Card(
              child: InkWell(
                onTap: () async {
                  final cubit = context.read<ProductsCubit>();
                  final result = await Navigator.push(context, ProductPage.getRoute(product: product));
                  if (result is bool && result) {
                    cubit.load();
                  }
                },
                child: Column(
                  children: [
                    SMNetworkImage(
                      imageUrl: product.imageUrl,
                      height: 117,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        product.title,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      case ExceptionState<List<ProductModel>>():
        return Text(state.exception.toString());
    }
  }
}
