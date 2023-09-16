import 'package:ecommerce/product_api/local_api.dart';
import 'package:flutter/material.dart';

import 'model/product.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(const MyApp());
  final api = LocalApi();
  await api.initDatabase();

  final product1 = Product(
    prodImage: 'abfahjgba',
    prodId: '1',
    prodName: 'DB LCD Temp',
    prodPrice: '12424',
  );

  final product2 = Product(
    prodImage: 'agtoewjtwjo',
    prodId: '2',
    prodName: 'DB afnak Temp',
    prodPrice: '35982759',
  );

  await api.saveAllProducts([product1, product2]);

  final productList = await api.getAllProducts();
  print('product list: ');
  logger.d(productList);

  await api.saveToCart(product1);

  print('cart list: ');
  logger.d(await api.getAllProductsFromCart());

  await api.removeFromCart(product1);

  logger.d(await api.getAllProductsFromCart());

  await api.saveRemark('This is a remark 1');
  logger.d(await api.getRemarks());
  await api.close();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECommerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(),
    );
  }
}
