// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      prodImage: json['prodImage'] as String,
      prodId: json['prodId'] as String,
      prodName: json['prodName'] as String,
      prodPrice: json['prodPrice'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'prodImage': instance.prodImage,
      'prodId': instance.prodId,
      'prodName': instance.prodName,
      'prodPrice': instance.prodPrice,
    };
