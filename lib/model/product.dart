import 'package:equatable/equatable.dart';

/// This model is used serializing db data to runtime instances.
/// The DB will provide the data and uses Product.fromMap method to serialize.
/// To post the data in DB toMap method is used to create or update db table.
class Product extends Equatable {
  final int? id;
  int count;
  final String prodImage, prodId, prodName, prodPrice;

  Product({
    this.id,
    required this.prodImage,
    required this.prodId,
    required this.prodName,
    required this.prodPrice,
    this.count = 0,
  });

  @override
  String toString() {
    return 'Product{id: $id, count: $count, prodImage: $prodImage, prodId: $prodId, prodName: $prodName, prodPrice: $prodPrice}';
  }

  Map<String, dynamic> toMap() {
    return {
      'prodImage': prodImage,
      'prodId': prodId,
      'prodName': prodName,
      'prodPrice': prodPrice,
      'count': count,
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        prodImage = map['prodImage'].toString(),
        prodId = map['prodId'].toString(),
        prodName = map['prodName'].toString(),
        prodPrice = map['prodPrice'].toString(),
        count = map['count'] ?? 0;

  @override
  List<Object?> get props => [prodId, prodName, prodPrice, prodImage];
}
