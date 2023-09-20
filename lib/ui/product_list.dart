import 'package:ecommerce/bloc/cart_bloc.dart';
import 'package:ecommerce/bloc/products_bloc.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  onPressed: () async {
                    final bloc = context.read<CartBloc>();

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (BuildContext context) => CartBloc(),
                          child: const Cart(),
                        ),
                      ),
                    );

                    bloc.add(LoadCartEvent());
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
          body: WillPopScope(
            onWillPop: popScope,
            child: BlocBuilder<ProductsBloc, ProductsState>(
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

                    return ListView.separated(
                      itemCount: state.products.length,
                      itemBuilder: (ctx, index) {
                        final product = state.products[index];
                        return ProductItem(product: product);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 16,
                      ),
                    );
                  }
                }

                return Container();
              },
            ),
          ),
        );
      },
    );
  }

  Future<bool> popScope() async {
    final bloc = context.read<CartBloc>();

    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Checkout'),
        content: const Text(
            'You will be checked out from this store and all products from cart will be removed!'),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setInt('store_id', 0);

              bloc.add(ClearCartEvent());

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                Constants.getSnackBar('Checked Out from store!'),
              );

              Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
    return shouldPop!;
  }
}
