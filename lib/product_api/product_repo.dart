import 'package:ecommerce/model/product.dart';

/// This single repo contains a declared method to get all products from Remote API
/// as well as Local API. It will be overridden, showing polymorphism.
abstract class ProductRepo{
  Future<List<Product>> getAllProducts();
}