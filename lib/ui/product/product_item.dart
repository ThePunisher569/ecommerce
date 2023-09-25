import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart_bloc.dart';
import '../../model/product.dart';
import '../../utils/constants.dart';

//TODO add product count widget

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    final productBloc = context.read<ProductsBloc>();

    final isAddedToCart =
        (cartBloc.state as CartStateLoaded).products.contains(product);

    logger.d('is this product added to cart? : $isAddedToCart');
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GridTile(
        footer: GridTileBar(
          title: Text(product.prodName),
          backgroundColor: Colors.indigo.shade400,
          subtitle: Text('${product.prodPrice} Rs'),
          trailing: isAddedToCart
              ? CounterWidget(product: product)
              : ElevatedButton.icon(
                  label: const Text('Add To Cart'),
                  onPressed: () {
                    cartBloc.add(AddToCartEvent(product));

                    productBloc.add(UpdateProductCountEvent(product));

                    cartBloc.add(LoadCartEvent());
                    productBloc.add(LoadProductsEvent());

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        Constants.getSnackBar('Product Added To Cart!'));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
        ),
        child: CachedNetworkImage(
          imageUrl: product.prodImage,
          fit: BoxFit.scaleDown,
          filterQuality: FilterQuality.high,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, error, stackTrace) => const Center(
              child: Icon(Icons.broken_image, size: 48, color: Colors.white70)),
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final Product product;

  const CounterWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    final productBloc = context.read<ProductsBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            cartBloc.add(DecreaseCountEvent(product));
            productBloc.add(UpdateProductCountEvent(product));

            cartBloc.add(LoadCartEvent());
            productBloc.add(LoadProductsEvent());
          },
          icon: const Icon(Icons.remove),
        ),
        Text('${product.count}',style: Theme.of(context).textTheme.labelLarge,),
        IconButton(
          onPressed: () {
            cartBloc.add(IncreaseCountEvent(product));
            productBloc.add(UpdateProductCountEvent(product));

            cartBloc.add(LoadCartEvent());
            productBloc.add(LoadProductsEvent());
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
