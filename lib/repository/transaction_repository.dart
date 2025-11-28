import 'package:hello_world/service/get_it/get_it.dart';
import 'package:hello_world/service/sqlite/model/transaction_model.dart' as model;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  final localStorage = getIt<SharedPreferences>();
  final db = getIt<Database>();

  Future<int> totalAmount() async {
    int userId = localStorage.getInt('userid')!;
    final res = await db.rawQuery('''
      select sum(amount) as total
      from transactions
      where userid = ?
    ''', [userId]);

    final total = res.first['total'] as int?;

    return total ?? 0;
  }

  Future<List<model.Transaction>> getAllTransactions() async {
    int userId = localStorage.getInt('userid')!;
    final res = await db.query(
      'transactions',
      where: 'userid = ?',
      whereArgs: [userId],
      orderBy: 'time desc'
    );

    return res.map((e) => model.Transaction.fromMap(e)).toList();
  }

  Future<int> createTransaction(model.Transaction t) async {
    final res = await db.insert(
      'transactions',
      t.toNewJson()
    );

    return res;
  }

}