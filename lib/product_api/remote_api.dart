import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../utils/constants.dart';
import 'product_repo.dart';

/// This class will deal with remote URL and it will parse json string
/// into serialized Product.
class RemoteApi extends ProductRepo {
  RemoteApi._();

  static RemoteApi? _instance;

  factory RemoteApi() {
    _instance ??= RemoteApi._();
    return _instance!;
  }

  /// Fetch products from API and save into Local DB product table
  @override
  Future<List<Product>> getAllProducts() async {
    logger.i('Fetching Product data');
    final productResponse = await http.get(Uri.parse(Constants.url));
    if (productResponse.statusCode == 200) {
      final productData =
          jsonDecode(productResponse.body)['data']['products'] as List;

      final productList =
          List<Product>.from(productData.map((e) => Product.fromMap(e)));
      return productList;
    } else {
      throw Exception(
          'Failed to fetch Product data due to ${productResponse.statusCode}');
    }
  }
}
