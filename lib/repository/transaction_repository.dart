import 'package:hello_world/service/sqlite/model/transaction_model.dart';
import 'package:hello_world/service/sqlite/sqlite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionRepository {
  final dbService = SqliteService.instance;

  Future<int> totalAmount() async {
    final db = await dbService.database;
    final localStorage = await SharedPreferences.getInstance();
    int userId = localStorage.getInt('userid')!;
    final res = await db.rawQuery('''
      select sum(amount) as total
      from transactions
      where userid = ?
    ''', [userId]);

    final total = res.first['total'] as int?;

    return total ?? 0;
  }

  Future<List<Transaction>> getAllTransactions() async {
    final db = await dbService.database;
    final localStorage = await SharedPreferences.getInstance();
    int userId = localStorage.getInt('userid')!;
    final res = await db.query(
      'transactions',
      where: 'userid = ?',
      whereArgs: [userId],
      orderBy: 'time desc'
    );

    return res.map((e) => Transaction.fromMap(e)).toList();
  }

  Future<int> createTransaction(Transaction t) async {
    final db = await dbService.database;
    final res = await db.insert(
      'transactions',
      t.toNewJson()
    );

    return res;
  }

}