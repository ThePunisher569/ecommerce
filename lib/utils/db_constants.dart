class DbConstants {
  // DB
  static const String dbName = 'ecommerce_database.db';
  static const String productTable = 'products';
  static const String cartTable = 'cart';

  // Columns
  static const String prodImage = 'prodImage';
  static const String prodName = 'prodName';
  static const String prodId = 'prodId';
  static const String prodPrice = 'prodPrice';

  //Queries
  static const String createProductQuery = '''CREATE TABLE products(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      $prodImage TEXT, 
      $prodId TEXT, 
      $prodName TEXT, 
      $prodPrice TEXT
      )''';

  static const String createCartQuery = '''CREATE TABLE cart(
      id INTEGER PRIMARY KEY autoincrement, 
      $prodImage TEXT, 
      $prodId TEXT, 
      $prodName TEXT, 
      $prodPrice TEXT
      )''';
}
