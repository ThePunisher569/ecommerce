import 'package:ecommerce/bloc/cart_bloc.dart';
import 'package:ecommerce/bloc/products_bloc.dart';
import 'package:ecommerce/product_api/local_api.dart';
import 'package:ecommerce/ui/product_list.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int storeId = 0;

  final localApi = LocalApi();

  /// This will check store id and re-route to that store product list
  Future<void> _checkStoreId() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      storeId = prefs.getInt('store_id') ?? 0;
    });

    print('store id is $storeId');

    if (storeId != 0 && context.mounted) {
      navigateToProductList(context);
    }
  }

  void navigateToProductList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
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
      ),
    );
  }

  @override
  void initState() {
    initDbAndRedirect();
    super.initState();
  }

  Future<void> initDbAndRedirect() async {
    await localApi.initDatabase();
    await _checkStoreId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.appBar,
      body: ListView(
        children: Constants.storeWidgetList,
      ),
    );
  }
}
