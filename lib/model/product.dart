import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(
  createFactory: true,
)
class Product {
  final String prodImage, prodId, prodName, prodPrice;

  Product(
      {required this.prodImage,
      required this.prodId,
      required this.prodName,
      required this.prodPrice});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  @override
  String toString() {
    return 'Product{prodImage: $prodImage, prodId: $prodId, prodName: $prodName, prodPrice: $prodPrice}';
  }
}
