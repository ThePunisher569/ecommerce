import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

import '../model/store.dart';

/// This contains all the compile time constants that are required
/// throughout the app
class Constants {

  /// The URL of API used in app
  static const url = 'https://www.jsonkeeper.com/b/MLTL';
  static const appName = 'E-Commerce';
  static const appDesc = 'Ecommerce Store product list and purchase';

  static const storeOneImage =
      'http://pngimagesfree.com/LOGO/R/Reliance-Digital/Reliance-Digital-Logo-PNG-Transparent-image.png';
  static const storeTwoImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Ikea_logo.svg/2560px-Ikea_logo.svg.png';
  static const storeThreeImage =
      'https://images.carriercms.com/image/upload/h_150,q_100,f_auto/v1573562016/common/logos/carrier-corp-logo.png';

  /// This is used to create listView in home.dart
  static const List<Store> storeWidgetList = [
    Store(
      1,
      ownerName: 'Reliance Digital',
      country: 'India',
      mobile: '3746367',
      city: 'Pune',
      state: 'Maharashtra',
      storeName: 'Reliance Digital',
      storeImage: storeOneImage,
    ),
    Store(
      2,
      ownerName: 'Ikea',
      country: 'US',
      mobile: '57568457',
      city: 'New York',
      state: 'New York',
      storeName: 'Ikea',
      storeImage: storeTwoImage,
    ),
    Store(
      3,
      ownerName: 'Carrier',
      country: 'India',
      mobile: '6854356',
      city: 'Mumbai',
      state: 'Maharashtra',
      storeName: 'Carrier',
      storeImage: storeThreeImage,
    )
  ];

  static const SizedBox gap8V = SizedBox(height: 8);
  static const SizedBox gap16V = SizedBox(height: 16);
  static const SizedBox gap32V = SizedBox(height: 32);
  static const SizedBox gap64V = SizedBox(height: 64);

  static const SizedBox gap16H = SizedBox(width: 16);

  static SnackBar getSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    );
  }

  static AppBar Function(String) appBar = (title) => AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      );
}

final logger = Logger();
