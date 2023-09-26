import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/cart_bloc.dart';
import '../../model/store.dart';
import '../../utils/constants.dart';
import '../cart.dart';
import '../product/product_list.dart';
import '../remark_widget.dart';
import 'store_widget.dart';

/// This screen is the home for the store. It will contain
/// Store details, Take order, No order and Checkout options
class StoreOptionsScreen extends StatefulWidget {
  final Store store;

  const StoreOptionsScreen({super.key, required this.store});

  @override
  State<StoreOptionsScreen> createState() => _StoreOptionsScreenState();
}

class _StoreOptionsScreenState extends State<StoreOptionsScreen> {
  bool shouldCheckout = false;

  void navigateToProductList(BuildContext context) async {
    if (!context.mounted) return;
    final bool r = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductList(
          storeId: widget.store.storeId,
          changeCheckoutStatus: changeCheckoutStatus,
        ),
      ),
    );

    if (r) {
      changeCheckoutStatus();
    }
  }

  void changeCheckoutStatus() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() => shouldCheckout = true);

    prefs.setBool('should_checkout', shouldCheckout);
  }

  @override
  void initState() {
    super.initState();

    final cartBloc = context.read<CartBloc>();

    cartBloc.add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (BuildContext context, CartState state) {
        final cartState = state as CartStateLoaded;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.store.storeName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: [
              Badge(
                largeSize: 24,
                label: Text('${cartState.products.length}'),
                child: IconButton(
                  onPressed: () async {
                    final bloc = context.read<CartBloc>();

                    final bool r = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Cart(changeCheckoutStatus: changeCheckoutStatus),
                      ),
                    );

                    if (r) {
                      changeCheckoutStatus();
                    }
                    bloc.add(LoadCartEvent());
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              )
            ],
          ),
          body: WillPopScope(
            onWillPop: popScope,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    StoreCard(store: widget.store),
                    Constants.gap16V,
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      style: ListTileStyle.list,
                      tileColor: Colors.blue.shade200,
                      title: const Text('Take Order'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => navigateToProductList(context),
                    ),
                    Constants.gap16V,
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      style: ListTileStyle.list,
                      tileColor: Colors.red.shade200,
                      title: const Text('No Order'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        final result = await showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              RemarkWidget(storeId: widget.store.storeId),
                        );
                        if (result) {
                          changeCheckoutStatus();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 96,
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.sizeOf(context).width, 54)),
                      onPressed: cartState.products.isNotEmpty || shouldCheckout
                          ? () async {
                              bool shouldPop = await popScope();
                              if (shouldPop && context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          : null,
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> popScope() async {
    final shouldPop = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Checkout'),
        content: const Text(
          'You will be checked out from this store and all products from cart will be removed!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: checkout,
            child: const Text('Yes'),
          )
        ],
      ),
    );
    return shouldPop!;
  }

  void checkout() async {
    final bloc = context.read<CartBloc>();
    bloc.add(ClearCartEvent());
    bloc.add(LoadCartEvent());

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('store_id', 0);

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      Constants.getSnackBar('Checked Out from store!'),
    );
    Navigator.pop(context, true);
  }
}
