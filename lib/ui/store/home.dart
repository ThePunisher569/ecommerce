import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../product_api/local_api.dart';
import 'store_options_screen.dart';
import 'store_widget.dart';

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
      navigateToStore(context);
    }
  }

  void navigateToStore(BuildContext context) {
    if (!context.mounted) return;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            StoreOptionsScreen(store: Constants.storeWidgetList[storeId - 1])));
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
      appBar: Constants.appBar('Stores'),
      body: ListView.separated(
        padding: const EdgeInsets.all(4),
        itemCount: Constants.storeWidgetList.length,
        itemBuilder: (context, index) =>
            StoreWidget(store: Constants.storeWidgetList[index]),
        separatorBuilder: (BuildContext context, int index) => Constants.gap16V,
      ),
    );
  }
}
