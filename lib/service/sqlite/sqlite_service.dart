import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static final SqliteService instance = SqliteService._init();
  static Database? _database;

  SqliteService._init();

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: createDB,
    );
  }

  Future createDB(Database db, int version) async {
    await db.execute(''' 
      create table if not exists users(
        id integer primary key autoincrement,
        username text not null unique,
        fullname text,
        email text not null unique,
        password text not null,
        role text,
        description text
      );
    ''');

    await db.execute('''
      create table if not exists transactions(
        id integer primary key autoincrement,
        userid integer not null,
        amount integer not null,
        description text,
        time text not null
      );
    ''');

    await db.execute('''
      insert into users values(1, 'admin', '', 'a@gmail.com', '123', '', '');
    ''');

    await db.execute('''
      insert into transactions values(1, 1, 10000, 'Tang qua', '${DateTime.now().toString()}');
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}