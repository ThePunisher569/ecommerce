import 'package:ecommerce/ui/product_list.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int storeId = 0;

  /// This will check store id and re-route to that store product list
  Future<void> _checkStoreId() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      storeId = prefs.getInt('store_id') ?? 0;
    });

    print('store id is $storeId');

    if (storeId != 0 && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductList(
            storeId: storeId,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkStoreId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('E-Commerce')),
      body: ListView(
        children: Constants.storeWidgetList,
      ),
    );
  }
}
