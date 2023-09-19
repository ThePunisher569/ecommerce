import 'package:ecommerce/bloc/cart_bloc.dart';
import 'package:ecommerce/bloc/products_bloc.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart.dart';
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
    // TODO add checkout on will pop
    return BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, CartState state) {
        final cartState = state as CartStateLoaded;

        return Scaffold(
          appBar: AppBar(
            title: const Text(Constants.appName),
            centerTitle: true,
            actions: [
              Badge(
                largeSize: 24,
                label: Text('${cartState.products.length}'),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (BuildContext context) => CartBloc(),
                          child: const Cart(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(16),
              child: Text(
                'You are Checked In with store id ${widget.storeId}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          body: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (BuildContext context, ProductsState state) {
              if (state is ProductsStateLoaded) {
                if (state.products.isEmpty) {
                  // product is loading
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.indigo,
                    ),
                  );
                } else {
                  logger.d(state.products);

                  return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (ctx, index) {
                        final product = state.products[index];
                        return ProductItem(product: product);
                      });
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
