import 'package:ecommerce/product_api/local_api.dart';
import 'package:flutter/material.dart';

import 'model/product.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(const MyApp());
  final api = LocalApi();
  await api.initDatabase();

  await api.saveAllProducts([
    Product(
        prodImage: 'abfahjgba',
        prodId: '1',
        prodName: 'DB LCD Temp',
        prodPrice: '12424'),
    Product(
        prodImage: 'agtoewjtwjo',
        prodId: '2',
        prodName: 'DB afnak Temp',
        prodPrice: '35982759'),
  ]);

  final productList = await api.getAllProducts();
  print('product list: ');
  logger.d(productList);

  logger.d(await api.getProduct('2'));
  await api.close();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(),
    );
  }
}
