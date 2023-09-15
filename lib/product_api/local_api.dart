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

    print('Deleting db....');
    await deleteDatabase(path);
    print('DB Deleted!');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creating table....');
        await db.execute(DbConstants.createProductQuery);
        await db.execute(DbConstants.createCartQuery);
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
    // TODO: implement getCartProducts
    throw UnimplementedError();
  }

  Future<void> addToCart(Product product) async {
    // TODO: implement addToCart
  }

  Future<void> removeFromCart(Product product) async {
    // TODO: implement removeFromCart
  }

  Future<void> emptyCart() async {
    // TODO: implement emptyCart
  }
}
