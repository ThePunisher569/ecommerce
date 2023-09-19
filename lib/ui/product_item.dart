import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../model/product.dart';
import '../utils/constants.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    final isAddedToCart =
        (cartBloc.state as CartStateLoaded).products.contains(widget.product);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GridTile(
        footer: GridTileBar(
          title: Text(widget.product.prodName),
          backgroundColor: Colors.indigo,
          subtitle: Text(widget.product.prodPrice),
          trailing: isAddedToCart
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    cartBloc.add(RemoveFromCart(widget.product));
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                        Constants.getSnackBar('Product Removed From Cart!'));
                  },
                  child: const Text('Remove From Cart'),
                )
              : ElevatedButton.icon(
                  label: const Text('Add To Cart'),
                  onPressed: () {
                    cartBloc.add(AddToCart(widget.product));

                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                        Constants.getSnackBar('Product Added To Cart!'));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
        ),
        child: CachedNetworkImage(
          imageUrl: widget.product.prodImage,
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
