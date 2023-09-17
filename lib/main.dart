import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  /*final remoteApi = RemoteApi();

  final api = LocalApi();
  await api.initDatabase();

  await api.saveAllProducts(await remoteApi.getAllProducts());
  logger.d(await api.getAllProducts());

  await api.saveToCart(await api.getProduct('1'));

  print('cart item: ');
  logger.d(await api.getProductFromCart('1'));

  await api.removeFromCart(await api.getProduct('1'));

  logger.d(await api.getAllProductsFromCart());

  await api.saveRemark('This is a remark 1');
  logger.d(await api.getRemarks());
  await api.close();*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
