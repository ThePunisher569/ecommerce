import 'package:flutter/material.dart';

class Store {
  final String storeName, ownerName, country, mobile, city, state;
  final Image storeImage;

  Store(
    this.ownerName,
    this.country,
    this.mobile,
    this.city,
    this.state,
    this.storeName,
    this.storeImage,
  );
}
