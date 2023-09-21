import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/cart_bloc.dart';
import '../../bloc/products_bloc.dart';
import '../product/product_list.dart';
import '../remark_widget.dart';

class StoreWidget extends StatelessWidget {
  final int storeId;

  final String name, image;

  const StoreWidget(
      {super.key,
      required this.storeId,
      required this.name,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.indigo.shade700,
          title: Text(name),
          trailing: ButtonBar(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400),
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) => RemarkWidget(storeId: storeId),
                  );
                },
                child: const Text('Add Remark'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('store_id', storeId);

                  print('prefs store_id set to $storeId');

                  if (!context.mounted) return;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (BuildContext context) => ProductsBloc(),
                        ),
                        BlocProvider(
                          create: (BuildContext context) => CartBloc(),
                        )
                      ],
                      child: ProductList(
                        storeId: storeId,
                      ),
                    ),
                  ));
                },
                child: const Text('Check In'),
              ),
            ],
          ),
        ),
        child: Card(
          color: Colors.indigo.shade200,
          child: CachedNetworkImage(
            imageUrl: image,
            alignment: Alignment.center,
            fit: BoxFit.contain,
            useOldImageOnUrlChange: true,
            filterQuality: FilterQuality.high,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, error, stackTrace) => const Center(
                child:
                    Icon(Icons.broken_image, size: 48, color: Colors.white70)),
          ),
        ),
      ),
    );
  }
}
