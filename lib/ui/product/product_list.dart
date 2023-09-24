import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart_bloc.dart';
import '../../bloc/products_bloc.dart';
import '../../utils/constants.dart';
import '../cart.dart';
import 'product_item.dart';

class ProductList extends StatefulWidget {
  final int storeId;

  const ProductList({super.key, required this.storeId});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    final bloc = context.read<ProductsBloc>();

    // Adding event to change product list state
    bloc.add(LoadProductsEvent());

    final cartBloc = context.read<CartBloc>();

    // Adding event to change cart list state
    cartBloc.add(LoadCartEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, CartState state) {
        final cartState = state as CartStateLoaded;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Available Products'),
            centerTitle: true,
            actions: [
              Badge(
                largeSize: 24,
                label: Text('${cartState.products.length}'),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Cart(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            ],
          ),
          body: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (BuildContext context, ProductsState state) {
              if (state is ProductsStateLoaded) {
                if (state.products.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.indigo,
                    ),
                  );
                } else {
                  logger.d(state.products);

                  return ListView.separated(
                    itemCount: state.products.length,
                    itemBuilder: (ctx, index) {
                      final product = state.products[index];
                      return ProductItem(product: product);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Constants.gap16V,
                  );
                }
              }

              return Container();
            },
          ),
        );
      },
    );
  }
}
