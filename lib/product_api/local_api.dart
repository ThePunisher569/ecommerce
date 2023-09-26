import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/product.dart';
import '../utils/db_constants.dart';
import 'product_repo.dart';

/// This class will deal with local db using sqlite queries following singleton
/// pattern.
class LocalApi extends ProductRepo {
  LocalApi._();

  /// Single instance of this class
  static LocalApi? _instance;

  /// Single instance of database
  late Database database;

  factory LocalApi() {
    _instance ??= LocalApi._();
    return _instance!;
  }

  // Products table methods

  /// Initialize DB and create tables if not created.
  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), DbConstants.dbName);

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creating table....');
        await db.execute(DbConstants.createProductQuery);
        await db.execute(DbConstants.createCartQuery);
        await db.execute(DbConstants.createRemarkQuery);
        print('Table created!');
      },
    );
  }

  /// close this connection
  Future close() async => await database.close();

  @override
  Future<List<Product>> getAllProducts() async {
    final productList = await database.query(DbConstants.productTable);

    return productList.map((e) => Product.fromMap(e)).toList();
  }

  /// Inserts a single product in product DB table
  Future<void> saveProduct(Product product) async {
    print('saving product ${product.toString()}');
    await database.insert(DbConstants.productTable, product.toMap());
    print('Product saved successfully!');
  }

  /// Inserts all products in product DB table
  Future<void> saveAllProducts(List<Product> products) async {
    print('Saving products....');
    for (final p in products) {
      await database.insert(DbConstants.productTable, p.toMap());
    }
    print('Product saved successfully!');
  }

  /// Return Product instance that matches prodID in DB
  Future<Product> getProduct(String prodId) async {
    final product = await database.query(
      DbConstants.productTable,
      where: 'prodId = ?',
      whereArgs: [prodId],
    );
    return Product.fromMap(product[0]);
  }

  /// Update the product count field in product db table.
  Future<void> updateProductCount(Product product) async {
    await database.update(
      DbConstants.productTable,
      product.toMap(),
      where: 'prodId = ?',
      whereArgs: [product.prodId],
    );
  }

  // Cart table methods

  /// Return all products that are present in cart
  Future<List<Product>> getAllProductsFromCart() async {
    final cartProducts = await database.query(DbConstants.cartTable);

    return cartProducts.map((e) => Product.fromMap(e)).toList();
  }

  /// Return a single product based on prodId that are present in cart
  Future<Product> getProductFromCart(String prodId) async {
    final product = await database.query(
      DbConstants.cartTable,
      where: 'prodId = ?',
      whereArgs: [prodId],
    );
    return Product.fromMap(product[0]);
  }

  /// Inserts the product to cart following ID and prodId.
  Future<void> saveToCart(Product product) async {
    print('Adding product to cart....');
    await database.insert(
        DbConstants.cartTable, product.toMap()..addAll({'id': product.id}));
    print('Product added successfully!');
  }

  /// Removes product from cart based on prodId
  Future<void> removeFromCart(Product product) async {
    print('Deleting product from cart....');
    await database.delete(
      DbConstants.cartTable,
      where: 'prodId = ?',
      whereArgs: [product.prodId],
    );
    print('Product Removed from cart....');
  }

  /// Update the product count field in cart db table.
  Future<void> updateCount(Product product) async {
    print('Updating count in cart');
    await database.update(
      DbConstants.cartTable,
      product.toMap(),
      where: 'prodId = ?',
      whereArgs: [product.prodId],
    );
  }

  /// Truncate the cart
  Future<void> emptyCart() async {
    print('Truncating cart....');
    await database.execute(DbConstants.emptyCartQuery);
    print('Cart truncated!');
  }

  // Remark methods

  /// Inserts a remark into remarks table
  Future<void> saveRemark(String remark) async {
    print('Adding remark: $remark');

    final map = {'remark': remark};
    await database.insert(DbConstants.remarksTable, map);

    print('remark added!');
  }

  /// Returns all remarks from remarks table
  Future<List<Map<String, dynamic>>> getRemarks() async {
    final remarks = await database.query(DbConstants.remarksTable);

    return remarks;
  }
}
