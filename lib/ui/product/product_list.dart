import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart_bloc.dart';
import '../../bloc/products_bloc.dart';
import '../../utils/constants.dart';
import '../cart.dart';
import 'product_item.dart';

class ProductList extends StatefulWidget {
  final int storeId;
  final Function() changeCheckoutStatus;
  const ProductList({super.key, required this.storeId, required this.changeCheckoutStatus});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    final bloc = context.read<ProductsBloc>();

    bloc.add(LoadProductsEvent());

    final cartBloc = context.read<CartBloc>();

    // Adding event to change cart list state
    cartBloc.add(LoadCartEvent());

    super.initState();
  }

  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      final cartState = state as CartStateLoaded;

      if (cartState.products.isNotEmpty) {
        totalPrice = cartState.products
            .map((product) => double.parse(product.prodPrice) * product.count)
            .reduce((value, element) => value + element);
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Available Products'),
          centerTitle: true,
          actions: [
            Badge(
              largeSize: 24,
              label: Text('${(state).products.length}'),
              child: IconButton(
                onPressed: () async {
                  final bool r = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(changeCheckoutStatus: widget.changeCheckoutStatus,),
                    ),
                  );
                  if (r) {
                    widget.changeCheckoutStatus();

                    if (!context.mounted) return;
                    Navigator.pop(context);
                  }
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

                return Column(
                  children: [
                    Expanded(
                      flex: 10,
                      child: ListView.separated(
                        itemCount: state.products.length,
                        itemBuilder: (ctx, index) {
                          final product = state.products[index];
                          return ProductItem(product: product);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Constants.gap16V,
                      ),
                    ),
                    Flexible(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Total Price: $totalPrice Rs',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          FilledButton(
                            onPressed: cartState.products.isEmpty
                                ? null
                                : () async {
                                    final cartBloc = context.read<CartBloc>();

                                    cartBloc.add(ClearCartEvent());
                                    cartBloc.add(LoadCartEvent());

                                    widget.changeCheckoutStatus();

                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        Constants.getSnackBar(
                                            'Orders Placed Successfully!'));

                                    Navigator.pop(context, true);
                                  },
                            child: const Text('Proceed to Purchase'),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            }

            return Container();
          },
        ),
      );
    });
  }
}
