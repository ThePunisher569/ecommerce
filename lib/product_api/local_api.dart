import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/product.dart';
import '../utils/db_constants.dart';
import 'product_repo.dart';

/// This class will deal with local db using sqlite queries
class LocalApi extends ProductRepo {
  LocalApi._();

  static LocalApi? _instance;
  late Database database;

  factory LocalApi() {
    _instance ??= LocalApi._();
    return _instance!;
  }

  // Products table methods

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

  Future close() async => await database.close();

  @override
  Future<List<Product>> getAllProducts() async {
    final productList = await database.query(DbConstants.productTable);

    return productList.map((e) => Product.fromMap(e)).toList();
  }

  Future<void> saveProduct(Product product) async {
    print('saving product ${product.toString()}');
    await database.insert(DbConstants.productTable, product.toMap());
    print('Product saved successfully!');
  }

  Future<void> saveAllProducts(List<Product> products) async {
    print('Saving products....');
    for (final p in products) {
      await database.insert(DbConstants.productTable, p.toMap());
    }
    print('Product saved successfully!');
  }

  Future<Product> getProduct(String prodId) async {
    final product = await database.query(
      DbConstants.productTable,
      where: 'prodId = ?',
      whereArgs: [prodId],
    );
    return Product.fromMap(product[0]);
  }

  // Cart table methods

  Future<List<Product>> getAllProductsFromCart() async {
    final cartProducts = await database.query(DbConstants.cartTable);

    return cartProducts.map((e) => Product.fromMap(e)).toList();
  }

  Future<Product> getProductFromCart(String prodId) async {
    final product = await database.query(
      DbConstants.cartTable,
      where: 'prodId = ?',
      whereArgs: [prodId],
    );
    return Product.fromMap(product[0]);
  }

  Future<void> saveToCart(Product product) async {
    print('Adding product to cart....');
    await database.insert(
        DbConstants.cartTable, product.toMap()..addAll({'id': product.id}));
    print('Product added successfully!');
  }

  Future<void> removeFromCart(Product product) async {
    print('Deleting product from cart....');
    await database.delete(
      DbConstants.cartTable,
      where: 'prodId = ?',
      whereArgs: [product.prodId],
    );
    print('Product Removed from cart....');
  }

  Future<void> emptyCart() async {
    print('Truncating cart....');
    await database.execute(DbConstants.emptyCartQuery);
    print('Cart truncated!');
  }

  // Remark methods

  Future<void> saveRemark(String remark) async {
    print('Adding remark: $remark');

    final map = {'remark': remark};
    await database.insert(DbConstants.remarksTable, map);

    print('remark added!');
  }

  Future<List<Map<String, dynamic>>> getRemarks() async {
    final remarks = await database.query(DbConstants.remarksTable);

    return remarks;
  }
}
