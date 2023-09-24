import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/cart_bloc.dart';
import '../utils/constants.dart';
import 'product/product_item.dart';
import 'store/home.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    final cartBloc = context.read<CartBloc>();

    // Adding event to change cart list state
    cartBloc.add(LoadCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.appBar('Cart'),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, CartState state) {
          if (state is CartStateLoaded) {
            if (state.products.isEmpty) {
              // product is loading
              return Center(
                child: Text(
                  'There are no items in the cart',
                  style: Theme.of(context).textTheme.titleLarge,
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
                        TextButton(
                          onPressed: () {
                            final cartBloc = context.read<CartBloc>();

                            cartBloc.add(ClearCartEvent());
                            cartBloc.add(LoadCartEvent());
                          },
                          child: const Text('Clear Cart'),
                        ),
                        FilledButton(
                          onPressed: () async {
                            final cartBloc = context.read<CartBloc>();

                            cartBloc.add(ClearCartEvent());

                            final pref = await SharedPreferences.getInstance();
                            pref.setInt('store_id', 0);

                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              Constants.getSnackBar('Checked Out from store!'),
                            );

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                ModalRoute.withName("/Home"));
                          },
                          child: const Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }

          return Container();
        },
      ),
    );
  }
}
