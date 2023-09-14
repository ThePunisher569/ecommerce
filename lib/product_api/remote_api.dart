import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../utils/constants.dart';
import 'product_repo.dart';

class ProductApi extends ProductRepo {
  ProductApi._();

  static ProductApi? _instance;

  factory ProductApi() {
    _instance ??= ProductApi._();
    return _instance!;
  }

  @override
  Future<List<Product>> getAllProducts() async {
    // TODO: implement getAllProducts
    throw UnimplementedError();
    // try {
    //   logger.i('Fetching Product data');
    //   final productResponse = await http.get(Uri.http(
    //     Constants.url,
    //     '/products',
    //   ));
    //
    //   if (productResponse.statusCode == 200) {
    //     final productData = jsonDecode(productResponse.body);
    //     //logger.d(ProductData);
    //
    //     final productList = ;
    //
    //     logger.i('Product data fetched and serialized successfully!');
    //     logger.d(product);
    //
    //     return product;
    //   } else {
    //     throw Exception(
    //         'Failed to fetch Product data due to ${productResponse.statusCode}');
    //   }
    // } on Exception catch (e) {
    //   logger.e('Error fetching Product data: $e');
    //   throw Exception('Error fetching Product data');
    // }
  }

  Future<void> saveProducts(Product product) async {
    //TODO save product in db which are fetched from api
  }
}
