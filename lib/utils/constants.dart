import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

import '../ui/store_widget.dart';

class Constants {
  static const url = 'https://www.jsonkeeper.com/b/YIDG';
  static const appName = 'E-Commerce';
  static const appDesc = 'Ecommerce Store product list and purchase';

  static const List<Widget> storeWidgetList = [
    StoreWidget(storeId: 1),
    SizedBox(height: 16),
    StoreWidget(storeId: 2),
    SizedBox(height: 16),
    StoreWidget(storeId: 3)
  ];
}

final logger = Logger();
