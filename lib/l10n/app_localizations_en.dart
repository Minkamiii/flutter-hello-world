// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get email => 'Email address';

  @override
  String get confirm_password => 'Confirm password';

  @override
  String get enter_username_or_password => 'Enter your username and password';

  @override
  String get forget_password => 'Forget password';

  @override
  String get dont_have_account => 'Don\'t have an account?';

  @override
  String get sign_up_here => 'Sign up here';

  @override
  String get login_success => 'Login success';

  @override
  String get login_failed => 'Login failed';

  @override
  String get wrong_username_or_password => 'Wrong username or password';

  @override
  String get create_account => 'Create account';

  @override
  String get create_account_to_get_started => 'Create account to get started';

  @override
  String get already_have_account => 'Already have an account?';

  @override
  String get sign_in_here => 'Sign in here';

  @override
  String get create_account_success => 'Create account successfully';

  @override
  String get invalid_credentials => 'Invalid Credentials';

  @override
  String get password_and_confirm_dont_match => 'Password and Confirm password don\'t match';

  @override
  String get enter_username_or_email => 'Enter your username or email';

  @override
  String get new_password => 'New password';

  @override
  String get confirm_new_password => 'Confirm new password';

  @override
  String get change_password => 'Change password';

  @override
  String get password_change_success => 'Password change success';

  @override
  String get username_or_email_dont_exists => 'Username or Email don\'t exists';

  @override
  String get cant_update_password => 'Can\'t update password';

  @override
  String get find_user => 'Find user';

  @override
  String purse_total(int amount) {
    return 'Purse: $amount VND';
  }

  @override
  String get day_format => 'yyyy/MM/dd HH-mm';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get full_name => 'Full name';

  @override
  String get role => 'Role';

  @override
  String get description => 'Description';

  @override
  String get update_profile => 'Update profile';

  @override
  String get update_profile_success => 'Update profile success';

  @override
  String get cant_load_profile => 'Can\'t load user profile';

  @override
  String get cant_update_profile => 'Can\'t update user profile';

  @override
  String get create_new_transaction => 'Create new transaction';

  @override
  String get load_transaction_failed => 'Failed to load transaction';

  @override
  String get create_transaction_failed => 'Failed to create transaction';

  @override
  String get transaction_type => 'Transaction type';

  @override
  String get amount => 'Amount';

  @override
  String get gain => 'gain';

  @override
  String get withdraw => 'withdraw';

  @override
  String get create_transaction_success => 'Create transaction successfull';

  @override
  String get cant_create_transaction => 'Can\'t create a new transaction';

  @override
  String get vi => 'Tiếng Việt';

  @override
  String get en => 'English';

  @override
  String get locale => 'Language';

  @override
  String get logout => 'Logout';

  @override
  String get accept_change => 'Accept changes';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get screen => 'Screen mode';
}
