import 'package:ecommerce/bloc/cart_bloc.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_item.dart';

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
      appBar: Constants.appBar,
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

              // TODO Add checkout method

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
  }
}
