import 'package:ecommerce/model/product.dart';

import 'product_repo.dart';

/// This class will deal with local db using sqlite queries
class LocalApi extends ProductRepo {
  LocalApi._();

  static LocalApi? _instance;

  factory LocalApi() {
    _instance ??= LocalApi._();
    return _instance!;
  }

  // Products table methods

  @override
  Future<List<Product>> getAllProducts() async{
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  Future<Product> getProduct(String prodId) async {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  // Cart table methods

  Future<List<Product>> getAllProductsFromCart() async{
    // TODO: implement getCartProducts
    throw UnimplementedError();
  }

  Future<void> addToCart(Product product) async {
    // TODO: implement addToCart
  }

  Future<void> removeFromCart(Product product) async {
    // TODO: implement removeFromCart
  }

  Future<void> emptyCart() async {
    // TODO: implement emptyCart
  }
}
