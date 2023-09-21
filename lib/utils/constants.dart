import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

import '../ui/store/store_widget.dart';

class Constants {
  static const url = 'https://www.jsonkeeper.com/b/YIDG';
  static const appName = 'E-Commerce';
  static const appDesc = 'Ecommerce Store product list and purchase';

  static const storeOneImage =
      'https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1695191182/Croma%20Assets/CMS/Header/Sept%202023/Croma_Logo_Animation_option2_jnj1bo.gif';
  static const storeTwoImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Ikea_logo.svg/2560px-Ikea_logo.svg.png';
  static const storeThreeImage =
      'https://images.carriercms.com/image/upload/h_150,q_100,f_auto/v1573562016/common/logos/carrier-corp-logo.png';

  static const List<Widget> storeWidgetList = [
    StoreWidget(storeId: 1, name: 'Croma', image: storeOneImage),
    SizedBox(height: 16),
    StoreWidget(storeId: 2, name: 'IKEA', image: storeTwoImage),
    SizedBox(height: 16),
    StoreWidget(storeId: 3, name: 'Carrier', image: storeThreeImage)
  ];

  static const SizedBox gap16V = SizedBox(height: 16);
  static const SizedBox gap32V = SizedBox(height: 32);

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
