import 'package:equatable/equatable.dart';
import 'package:hello_world/enumerator/type.dart';

class SettingState extends Equatable {

  final LocaleType currentLocale;
  final LocaleType selectedLocale;
  final AppThemeType currentTheme;
  final AppThemeType selectedTheme;
  final bool hadChanges;
  final bool loggedOut;

  const SettingState({
    required this.currentLocale,
    required this.selectedLocale,
    required this.selectedTheme,
    required this.currentTheme,
    required this.hadChanges,
    required this.loggedOut
  });

  factory SettingState.initial() {
    return SettingState(
      currentLocale: LocaleType.en,
      selectedLocale: LocaleType.en,
      currentTheme: AppThemeType.light,
      selectedTheme: AppThemeType.light,
      hadChanges: false,
      loggedOut: false
    );
  }

  SettingState copyWith({
    LocaleType? currentLocale,
    LocaleType? selectedLocale,
    AppThemeType? currentTheme,
    AppThemeType? selectedTheme,
    bool? hadChanges,
    bool? loggedOut
  }) {
    return SettingState(
      currentLocale: currentLocale ?? this.currentLocale, 
      selectedLocale: selectedLocale ?? this.selectedLocale,
      currentTheme: currentTheme ?? this.currentTheme,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      hadChanges: hadChanges ?? this.hadChanges,
      loggedOut: loggedOut ?? this.loggedOut
    );
  }

  @override
  List<Object?> get props => [currentLocale, selectedLocale, selectedTheme, currentTheme, hadChanges, loggedOut];
}