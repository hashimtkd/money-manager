import 'package:money_maneger_provider_sqflite/model/transaction_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDb {
  static final TransactionDb instance = TransactionDb._internal();
  static Database? _database;
  TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'transaction.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        key INTEGER PRIMARY KEY AUTOINCREMENT,
        purpose TEXT,
        amount TEXT,
        type TEXT,
        category TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    Database db = await instance.db;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    Database db = await instance.db;

    final List<Map<String, dynamic>> maps = await db.query('transactions');

    return List.generate(maps.length, (i) {
      return TransactionModel.fromMap(maps[i]);
    });
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    Database db = await instance.db;
    return await db.update(
      'transaction',
      transaction.toMap(),
      where: 'key = ?',
      whereArgs: [transaction.key],
    );
  }

  Future<int> deleteUser(int key) async {
    Database db = await instance.db;
    return await db.delete('transaction', where: 'key = ?', whereArgs: [key]);
  }
}
