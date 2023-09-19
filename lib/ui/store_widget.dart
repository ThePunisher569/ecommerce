import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/products_bloc.dart';
import 'product_list.dart';
import 'remark_widget.dart';

class StoreWidget extends StatelessWidget {
  final int storeId;

  const StoreWidget({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.indigo,
          title: Text('Store $storeId'),
          trailing: ButtonBar(
            children: [
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
              ElevatedButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) => RemarkWidget(storeId: storeId),
                  );

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(Constants.getSnackBar('Remark Added!'));
                },
                child: const Text('Remark'),
              ),
            ],
          ),
        ),
        child: const Placeholder(),
      ),
    );
  }
}
