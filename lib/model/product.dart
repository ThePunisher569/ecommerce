import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String prodImage, prodId, prodName, prodPrice;

  const Product({
    this.id,
    required this.prodImage,
    required this.prodId,
    required this.prodName,
    required this.prodPrice,
  });

  @override
  String toString() {
    return 'Product{id: $id, prodImage: $prodImage, prodId: $prodId, prodName: $prodName, prodPrice: $prodPrice}';
  }

  Map<String, dynamic> toMap() {
    return {
      'prodImage': prodImage,
      'prodId': prodId,
      'prodName': prodName,
      'prodPrice': prodPrice,
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        prodImage = map['prodImage'].toString(),
        prodId = map['prodId'].toString(),
        prodName = map['prodName'].toString(),
        prodPrice = map['prodPrice'].toString();

  @override
  List<Object?> get props => [prodId, prodName, prodPrice];
}
