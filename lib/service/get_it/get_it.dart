
import 'package:get_it/get_it.dart';
import 'package:hello_world/repository/auth_repository.dart';
import 'package:hello_world/repository/transaction_repository.dart';
import 'package:hello_world/service/sqlite/sqlite_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final preps = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(preps);

  getIt.registerLazySingleton<SqliteService>(() => SqliteService.instance);
  getIt.registerSingletonAsync<Database>(
    () async => await getIt<SqliteService>().database
  );

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<TransactionRepository>(() => TransactionRepository());
}