import 'package:flutter/material.dart';
import 'package:hello_world/enumerator/type.dart';
import 'package:hello_world/l10n/app_localizations.dart';

extension LocaleTypeTypeLocalization on LocaleType {
  String localized(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    switch (this) {
      case LocaleType.en:
        return loc.en;
      case LocaleType.vi:
        return loc.vi;
    }
  }
}