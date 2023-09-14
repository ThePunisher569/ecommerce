import 'package:ecommerce/model/product.dart';

abstract class ProductRepo{
  Future<List<Product>> getAllProducts();
}