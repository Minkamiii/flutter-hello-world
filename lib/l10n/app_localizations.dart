import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get email;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password;

  /// No description provided for @enter_username_or_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your username and password'**
  String get enter_username_or_password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forget_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @sign_up_here.
  ///
  /// In en, this message translates to:
  /// **'Sign up here'**
  String get sign_up_here;

  /// No description provided for @login_success.
  ///
  /// In en, this message translates to:
  /// **'Login success'**
  String get login_success;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get login_failed;

  /// No description provided for @wrong_username_or_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong username or password'**
  String get wrong_username_or_password;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get create_account;

  /// No description provided for @create_account_to_get_started.
  ///
  /// In en, this message translates to:
  /// **'Create account to get started'**
  String get create_account_to_get_started;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @sign_in_here.
  ///
  /// In en, this message translates to:
  /// **'Sign in here'**
  String get sign_in_here;

  /// No description provided for @create_account_success.
  ///
  /// In en, this message translates to:
  /// **'Create account successfully'**
  String get create_account_success;

  /// No description provided for @invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid Credentials'**
  String get invalid_credentials;

  /// No description provided for @password_and_confirm_dont_match.
  ///
  /// In en, this message translates to:
  /// **'Password and Confirm password don\'t match'**
  String get password_and_confirm_dont_match;

  /// No description provided for @enter_username_or_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your username or email'**
  String get enter_username_or_email;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirm_new_password;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get change_password;

  /// No description provided for @password_change_success.
  ///
  /// In en, this message translates to:
  /// **'Password change success'**
  String get password_change_success;

  /// No description provided for @username_or_email_dont_exists.
  ///
  /// In en, this message translates to:
  /// **'Username or Email don\'t exists'**
  String get username_or_email_dont_exists;

  /// No description provided for @cant_update_password.
  ///
  /// In en, this message translates to:
  /// **'Can\'t update password'**
  String get cant_update_password;

  /// No description provided for @find_user.
  ///
  /// In en, this message translates to:
  /// **'Find user'**
  String get find_user;

  /// No description provided for @purse_total.
  ///
  /// In en, this message translates to:
  /// **'Purse: {amount} VND'**
  String purse_total(int amount);

  /// No description provided for @day_format.
  ///
  /// In en, this message translates to:
  /// **'yyyy/MM/dd HH-mm'**
  String get day_format;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @update_profile.
  ///
  /// In en, this message translates to:
  /// **'Update profile'**
  String get update_profile;

  /// No description provided for @update_profile_success.
  ///
  /// In en, this message translates to:
  /// **'Update profile success'**
  String get update_profile_success;

  /// No description provided for @cant_load_profile.
  ///
  /// In en, this message translates to:
  /// **'Can\'t load user profile'**
  String get cant_load_profile;

  /// No description provided for @cant_update_profile.
  ///
  /// In en, this message translates to:
  /// **'Can\'t update user profile'**
  String get cant_update_profile;

  /// No description provided for @create_new_transaction.
  ///
  /// In en, this message translates to:
  /// **'Create new transaction'**
  String get create_new_transaction;

  /// No description provided for @load_transaction_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load transaction'**
  String get load_transaction_failed;

  /// No description provided for @create_transaction_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create transaction'**
  String get create_transaction_failed;

  /// No description provided for @transaction_type.
  ///
  /// In en, this message translates to:
  /// **'Transaction type'**
  String get transaction_type;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @gain.
  ///
  /// In en, this message translates to:
  /// **'gain'**
  String get gain;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'withdraw'**
  String get withdraw;

  /// No description provided for @create_transaction_success.
  ///
  /// In en, this message translates to:
  /// **'Create transaction successfull'**
  String get create_transaction_success;

  /// No description provided for @cant_create_transaction.
  ///
  /// In en, this message translates to:
  /// **'Can\'t create a new transaction'**
  String get cant_create_transaction;

  /// No description provided for @vi.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get vi;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

  /// No description provided for @locale.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get locale;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @accept_change.
  ///
  /// In en, this message translates to:
  /// **'Accept changes'**
  String get accept_change;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @screen.
  ///
  /// In en, this message translates to:
  /// **'Screen mode'**
  String get screen;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
