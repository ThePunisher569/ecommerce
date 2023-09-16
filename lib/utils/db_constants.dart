class DbConstants {
  // DB
  static const String dbName = 'ecommerce_database.db';
  static const String productTable = 'products';
  static const String cartTable = 'cart';
  static const String remarksTable = 'remarks';

  // Columns
  static const String prodImage = 'prodImage';
  static const String prodName = 'prodName';
  static const String prodId = 'prodId';
  static const String prodPrice = 'prodPrice';

  // Queries
  static const String createProductQuery = '''CREATE TABLE $productTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      $prodImage TEXT, 
      $prodId TEXT, 
      $prodName TEXT, 
      $prodPrice TEXT
      )''';

  static const String createCartQuery = '''CREATE TABLE $cartTable(
      id INTEGER PRIMARY KEY autoincrement, 
      $prodImage TEXT, 
      $prodId TEXT, 
      $prodName TEXT, 
      $prodPrice TEXT
      )''';

  static const String createRemarkQuery = '''CREATE TABLE $remarksTable(
      id INTEGER PRIMARY KEY autoincrement, remark TEXT)''';

  static const String emptyCartQuery = 'DELETE FROM $cartTable';
}
