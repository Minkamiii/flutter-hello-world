import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/l10n/app_localizations.dart';
import 'package:hello_world/ui/pages/settings/cubit/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingCubit extends Cubit<SettingState> {

  final AppLocalizations loc;

  SettingCubit(this.loc) :  super(SettingState.initial()) {
    load();
  }

  Future<void> load() async {
    final localStorage = await SharedPreferences.getInstance();
    final locale =  localStorage.getString('locale');
    final theme = localStorage.getString('theme');
    LocaleType lang = LocaleType.en;
    AppThemeType appTheme = AppThemeType.light;

    switch(locale){
      case "en":
        lang = LocaleType.en;
      case "vi":
        lang = LocaleType.vi;
      case null:
        lang = LocaleType.en;
    }

    switch(theme){
      case "light":
        appTheme = AppThemeType.light;
      case "dark":
        appTheme = AppThemeType.dark;
      case null:
        appTheme = AppThemeType.light;
    }

    emit(state.copyWith(
      currentLocale: lang,
      selectedLocale: lang,
      currentTheme: appTheme,
      selectedTheme: appTheme,
      hadChanges: false
    )); 
  }

  void changeLanguage(LocaleType locale){
    emit(
      state.copyWith(
        selectedLocale: locale,
        hadChanges: locale != state.currentLocale
      )
    );
  }

  void changeTheme(AppThemeType theme){
    emit(
      state.copyWith(
        selectedTheme: theme,
        hadChanges: theme != state.currentTheme
      )
    );
  }

  Future<void> confirmChanges() async {
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString('locale', state.selectedLocale.name);
    localStorage.setString('theme', state.currentTheme.name);

    emit(
      state.copyWith(
        currentLocale: state.selectedLocale,
        currentTheme: state.selectedTheme,
        hadChanges: false
      )
    );
  }

  void logout() async {
    final localStorage = await SharedPreferences.getInstance();
    localStorage.remove('userid');

    emit(state.copyWith(
      loggedOut: true,
    ));
  }

}