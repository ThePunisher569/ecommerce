import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/cart_bloc.dart';
import '../utils/constants.dart';
import 'product/product_item.dart';

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

              double totalPrice = state.products
                  .map((product) =>
                      double.parse(product.prodPrice) * product.count)
                  .reduce((value, element) => value + element);

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
                          onPressed: state.products.isEmpty
                              ? null
                              : () async {
                                  final cartBloc = context.read<CartBloc>();

                                  cartBloc.add(ClearCartEvent());
                                  cartBloc.add(LoadCartEvent());

                                  final prefs =
                                      await SharedPreferences.getInstance();

                                  prefs.setBool('should_checkout', true);

                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      Constants.getSnackBar(
                                          'Order Placed Successfully!'));

                                  Navigator.pop(context, true);
                                },
                          child: const Text('Proceed to Purchase'),
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
