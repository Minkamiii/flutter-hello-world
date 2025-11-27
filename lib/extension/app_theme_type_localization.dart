import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/l10n/app_localizations.dart';

extension AppThemeTypeLocalization on AppThemeType {
  String localized(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    switch (this) {
      case AppThemeType.light:
        return loc.light;
      case AppThemeType.dark:
        return loc.dark;
    }
  }
}