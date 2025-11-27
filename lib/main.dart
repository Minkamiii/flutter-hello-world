import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/ui/theme/app_theme.dart';
import 'package:hello_world/notifier/locale_provider.dart';
import 'package:hello_world/ui/pages/add_transaction/add_transaction.dart';
import 'package:hello_world/ui/pages/change_password/forgot_password_page.dart';
import 'package:hello_world/ui/pages/home/home_page.dart';
import 'package:hello_world/ui/pages/login/login_page.dart';
import 'package:hello_world/ui/pages/register/register_page.dart';
import 'package:hello_world/notifier/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart'

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final provider = LocaleProvider();
  await provider.loadLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: provider),
        ChangeNotifierProvider(create: (_) => ThemeProvider())
      ],
      child: App(),
    )
  );
}

class App extends StatelessWidget {
  App({super.key});

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
    final localeProvider = context.watch<LocaleProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      routerConfig: _router,
      locale: localeProvider.locale,
      supportedLocales: const [Locale('en'), Locale('vi')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}