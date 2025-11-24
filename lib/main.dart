import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/service/sqlite/sqlite_service.dart';
import 'package:hello_world/ui/add_transaction.dart';
import 'package:hello_world/ui/forgot_password_page.dart';
import 'package:hello_world/ui/home_page.dart';
import 'package:hello_world/ui/login_page.dart';
import 'package:hello_world/ui/register_page.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart'

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final db = SqliteService.instance;

  final GoRouter _router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/register',
        builder:(context, state) => Register(),
      ),
      GoRoute(
        path: '/home',
        builder:(context, state) => Home(),
      ),
      GoRoute(
        path: '/add/transaction',
        builder: (context, state) => AddTransaction(),
      ),
      GoRoute( 
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordPage(),
      ),
    ]
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }}
