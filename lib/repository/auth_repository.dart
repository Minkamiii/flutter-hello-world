import 'package:hello_world/service/get_it/get_it.dart';
import 'package:hello_world/service/sqlite/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class AuthRepository {
  final db = getIt<Database>();

  Future<User?> login(String username, String password) async {
    final maps = await db.query(
      'users',
      where: 'username = ? and password = ?',
      whereArgs: [username, password]
    );

    if(maps.isNotEmpty){
      return User.fromLoginJson(maps.first);
    }

    return null;
  }

  Future<int> register(String username, String password, String email) async {
    return await db.insert(
      'users',
      User(
        username: username, 
        password: password, 
        email: email,
      ).toRegisterJson() 
    );
  }

  Future<int> update(User user) async{
    return db.update(
      'users', 
      user.toUpdateProfileJson(),
      where: 'id = ?',
      whereArgs: [user.id]
    );
  }

  Future<User?> get(int id) async {
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty) return User.fromProfileJson(maps.first);
    return null; 
  }

  Future<bool> userExists(String usernameOrEmail) async {
    final maps = await db.query(
      'users',
      where: 'username = ? or email = ?',
      whereArgs: [usernameOrEmail, usernameOrEmail]
    );

    if(maps.isNotEmpty) return true;
    return false;
  }

  Future<int> delete(int id) async {
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<int> changePassword(String usernameOrEmail, String password) async {
    final maps = await db.update(
      'users',
      {'password': password},
      where: 'username = ? or email = ?',
      whereArgs: [usernameOrEmail, usernameOrEmail]
    );

    return maps;
  }
}